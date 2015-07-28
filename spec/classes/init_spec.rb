require 'spec_helper'

describe 'golang' do
  let(:facts) { { osfamily: 'RedHat', environment: 'production' } }

  context 'with defaults for all parameters' do
    it { should contain_class('golang') }

    it do
      should contain_vcsrepo('/usr/local/go').with(
        'revision' => 'go1.4.2'
      )
    end
  end

  context 'when version is string' do
    let(:params) do
      { version: 'release-branch1.4' }
    end

    it do
      should contain_vcsrepo('/usr/local/go').with(
        'revision' => 'release-branch1.4'
      )
    end
  end

  context 'when version is invalid' do
    let(:params) do
      { version: true }
    end

    it { expect(subject).to raise_error(Puppet::Error, /true is not a string/) }
  end
end
