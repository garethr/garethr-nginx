require 'spec_helper_system'

describe 'nginx' do
  context 'with repo set to mainsteam' do
    it 'should work without errors' do
      pp = <<-EOS
        class { 'nginx':
          repo => 'mainline',
        }
      EOS

      puppet_apply(pp) do |run|
        run.exit_code.should == 2
        run.refresh
        run.exit_code.should be_zero
      end
    end

    describe service('nginx') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
