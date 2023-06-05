require 'rspec'

require_relative "../bin/tmux_utils"

RSpec.describe TmuxUtils do
  subject { TmuxUtils }

  after do
    $debug = false
  end

  describe ".tmux_run" do
    def invoke!(*cmds)
      subject.tmux_run(*cmds)
    end

    it "runs a single command" do
      expect(subject).to receive(:`).with("tmux foo").ordered
      expect(subject).to receive(:exit_status) { 0 }.ordered
      invoke!("foo")
    end

    it "runs multiple commands" do
      expect(subject).to receive(:`).with("tmux foo").ordered
      expect(subject).to receive(:exit_status) { 0 }.ordered
      expect(subject).to receive(:`).with("tmux bar").ordered
      expect(subject).to receive(:exit_status) { 0 }.ordered
      invoke!("foo", "bar")
    end

    it "fails if exit status is nonzero" do
      expect(subject).to receive(:`).with("tmux foo").ordered
      expect(subject).to receive(:exit_status) { 1 }.ordered
      expect { invoke!("foo") }.to raise_error( RuntimeError, /Command failed/ )
    end
  end

  describe ".vim_and_shell" do
    it "finds the next two adjacent window numbers, runs vim in the first one, and a shell in the second" do
      expect( subject ).to receive( :next_n_adjacent_windows ).with( 2                           ).and_return( [17,23] ).ordered
      expect( subject ).to receive( :tmux_new_window         ).with( 17, "foo", "foo vim", "vim" ).ordered
      expect( subject ).to receive( :tmux_new_window         ).with( 23, "foo", "foo"            ).ordered
      subject.vim_and_shell "foo"
    end

    specify "the :label kwarg gets used to label the windows" do
      expect( subject ).to receive( :next_n_adjacent_windows ).with( 2                            ).and_return( [17,23] ).ordered
      expect( subject ).to receive( :tmux_new_window         ).with( 17, "foo", "spam vim", "vim" ).ordered
      expect( subject ).to receive( :tmux_new_window         ).with( 23, "foo", "spam"            ).ordered
      subject.vim_and_shell "foo", label: "spam"
    end
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

  describe ".compact_windows" do
    it "complains if you have more than 9 windows" do
      expect( subject ).to receive(:window_numbers).and_return( [ 1, 2, 10 ] )
      expect { subject.compact_windows }.to raise_error( /You have windows past #9/ )
    end

    it "leaves window 0 alone" do
      expect( subject ).to receive(:window_numbers).and_return( [ 0 ] )
      expect( subject ).to_not receive(:move_window)
      subject.compact_windows
    end

    it "leaves window 9 alone" do
      expect( subject ).to receive(:window_numbers).and_return( [ 9 ] )
      expect( subject ).to_not receive(:move_window)
      subject.compact_windows
    end

    context "in dry-run mode" do
      def invoke!
        subject.compact_windows(dry_run: true)
      end

      specify "it turns 1,2,5 into 1,2,3" do
        expect( subject ).to receive(:window_numbers).and_return( [ 1,2,5 ] )
        expect( invoke! ).to eq(
          "wibble" 
        )
      end
    end

    it "doesn't change anything if the :dry_run kwarg is truthy"
    it "remembers the current and previous windows, and returns to them when done"
    it "compacts windows from 1-8"
  end
end
