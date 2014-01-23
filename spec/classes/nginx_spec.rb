require 'spec_helper'

describe 'nginx' do

  context 'on Ubuntu' do
    let(:facts) {{
      :osfamily        => 'Debian',
      :lsbdistcodename => 'maverick',
      :kernelrelease   => '3.8.0-29-generic'
    }}

    it { should include_class('nginx::params') }

    it { should contain_class('nginx::install').that_comes_before('nginx::config') }
    it { should contain_class('nginx::config') }
    it { should contain_class('nginx::service').that_subscribes_to('nginx::config') }

    it { should contain_service('nginx') }
    it { should contain_package('nginx').with_ensure('present') }

    describe 'with the stable repository' do
      let(:params) { {'repo' => 'stable' } }
      it { should contain_apt__source('nginx').with_location('http://nginx.org/packages/ubuntu') }
    end

    describe 'with the mainline repository' do
      let(:params) { {'repo' => 'mainline' } }
      it { should contain_apt__source('nginx').with_location('http://nginx.org/packages/mainline/ubuntu') }
    end

    describe 'with an invalid repository' do
      let(:params) { {'repo' => 'invalid' } }
      it { expect { should }.to raise_error(Puppet::Error) }
    end

  end

  context 'on all operation systems' do
    let(:facts) {{ :osfamily => 'Debian' }}

    describe 'with ensure latest' do
      let(:params) { {'ensure' => 'latest' } }
      it { should contain_package('nginx').with_ensure('latest') }
    end

    describe 'with an invalid ensure value' do
      let(:params) { {'ensure' => 'custom' } }
      it { expect { should }.to raise_error(Puppet::Error) }
    end

    describe 'with an ensure absent' do
      let(:params) { {'ensure' => 'absent' } }
      it { should contain_package('nginx').with_ensure('absent') }
      it { should_not contain_service('nginx') }
    end

  end

  context 'on an unsupported operating system' do
    describe 'on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /This module only works on Debian or RedHat/) }
    end
  end
end
