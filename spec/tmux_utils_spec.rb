require 'rspec'

require_relative "../bin/tmux_utils"

RSpec.describe TmuxUtils do
  subject { TmuxUtils }

  after do
    $debug = false
  end

  describe ".next_n_adjacent_windows" do
    def windows_in_use(*ns)
      expect(subject).to receive(:`)
        .with("tmux list-windows")
        .and_return(ns.flatten.join("\n"))
      # The actual output has a lot more detail, but we throw it away anyway soooo ¯\_(ツ)_/¯
    end

    context "when asked for two windows" do
      let(:result) { TmuxUtils.next_n_adjacent_windows(2) }

      it "returns [1,2] when only window 0 is in use" do
        windows_in_use 0
        expect( result ).to eq( [1,2] )
      end

      it "returns [3,4] when [1,2] are in use" do
        windows_in_use [1,2]
        expect( result ).to eq( [3,4] )
      end

      it "returns [5,6] when [1,2,4] are in use" do
        windows_in_use [1,2,4]
        expect( result ).to eq( [5,6] )
      end

      it "returns [3,4] when [1,2,5] are in use" do
        windows_in_use [1,2,5]
        expect( result ).to eq( [3,4] )
      end

      it "returns [8,9] when 1-7 are in use" do
        windows_in_use (1..7).to_a
        expect( result ).to eq( [8,9] )
      end

      it "raises OutOfWindows when 1-8 are in use" do
        windows_in_use (1..8).to_a
        expect { result }.to raise_error( subject::OutOfWindows )
      end
    end

    context "when asked for three windows" do
      let(:result) { TmuxUtils.next_n_adjacent_windows(3) }

      it "returns [1,2,3] when only window 0 is in use" do
        windows_in_use 0
        expect( result ).to eq( [1,2,3] )
      end

      it "returns [3,4,5] when [1,2] are in use" do
        windows_in_use [1,2]
        expect( result ).to eq( [3,4,5] )
      end

      it "returns [5,6,7] when [1,2,4] are in use" do
        windows_in_use [1,2,4]
        expect( result ).to eq( [5,6,7] )
      end

      it "returns [3,4,5] when [1,2,6] are in use" do
        windows_in_use [1,2,6]
        expect( result ).to eq( [3,4,5] )
      end
    end
  end
end
