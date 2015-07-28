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
end
