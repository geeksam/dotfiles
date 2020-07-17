require 'rspec'
require 'date'
require 'json'
require 'pathname'


SPEC_DIR = Pathname.new( File.dirname(__FILE__) )
# require_relative '../bin/kbash'
load SPEC_DIR.join("../bin/kbash")

RSpec.shared_context "pods" do
  subject(:pods) { Pods.new(get_pods_output) }
  subject(:pods_during_startup) { Pods.new(get_pods_output_with_container_creating) }

  let(:get_pods_output) {
    <<~EOF
      NAME                         READY   STATUS    RESTARTS   AGE
      mumble-api-abc123-j79xl      1/1     Running   0          8d
      mumble-api-abc123-qxcn6      1/1     Running   0          4h
      mumble-worker-abc123-nhbkn   1/1     Running   0          3m42s
      mumble-worker-abc123-q5bnx   1/1     Bogus     0          23s
    EOF
  }
  let(:get_pods_output_with_container_creating) {
    <<~EOF
      NAME                         READY   STATUS              RESTARTS   AGE
      mumble-api-abc123-j79xl      1/1     Running             0          8d
      mumble-api-abc123-qxcn6      1/1     Running             0          4h
      mumble-worker-abc123-nhbkn   1/1     Running             0          9m
      mumble-worker-abc123-q5bnx   1/1     ContainerCreating   0          23s
    EOF
  }
end

RSpec.describe Pods do
  include_context "pods"

  it "can construct itself from the output of `kubectl get pods`" do
    expect( pods        ).to be_a( Pods )
    expect( pods.length ).to eq( 4 )
    expect( pods.first  ).to be_a( Pod )
  end

  it "can return the youngest running pod" do
    pod = pods.fresh_meat
    expect( pod      ).to be_a( Pod )
    expect( pod.name ).to eq( "mumble-worker-abc123-nhbkn" )
  end

  it "can return the youngest running pod whose name matches a substring" do
    api_pods = pods.matching_name("api")
    expect( api_pods             ).to be_a( Pods )
    expect( api_pods.length      ).to eq( 2 )
    expect( api_pods.map(&:name) ).to eq([
      "mumble-api-abc123-j79xl",
      "mumble-api-abc123-qxcn6",
    ])
  end

  specify "#fresh_meat refuses to return the youngest running matching pod if matching pods include any in 'ContainerCreating' status" do
    pod = pods_during_startup.fresh_meat
    expect( pod ).to be nil
  end
end

RSpec.describe Pod do
  include_context "pods"

  it "knows if it is running" do
    expect( pods.first ).to be_running
  end

  it "knows if it is creating containers" do
    expect( pods_during_startup.last ).to be_in_startup
  end

  it "knows its name" do
    expect( pods.map(&:name) ).to eq([
      "mumble-api-abc123-j79xl",
      "mumble-api-abc123-qxcn6",
      "mumble-worker-abc123-nhbkn",
      "mumble-worker-abc123-q5bnx",
    ])
  end

  it "knows its age" do
    expect( pods.map(&:age) ).to eq([
      8 * 60 * 60 * 24,
      4 * 60 * 60,
      3 * 60,
      23,
    ])
  end

  it "knows if it's running" do
    expect( pods.map(&:running?) ).to eq([
      true,
      true,
      true,
      false,
    ])
  end
end

