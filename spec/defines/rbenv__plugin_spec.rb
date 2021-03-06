require 'spec_helper'

describe 'rbenv::plugin', :type => :define do
  let(:user)        { 'tester' }
  let(:plugin_name) { 'rbenv-vars' }
  let(:dot_rbenv)   { "/home/#{user}/.rbenv" }
  let(:source)      { 'https://github.com/rbenv/plugin' }
  let(:title)       { "rbenv::plugin::#{user}::#{plugin_name}" }
  let(:params)      { {:user => user, :plugin_name => plugin_name, :source => source} }

  let(:target_path) { "#{dot_rbenv}/plugins/#{plugin_name}" }

  it 'clones repository to the right path' do
    should contain_vcsrepo("#{dot_rbenv}/plugins/#{plugin_name}").with(
      :ensure   => 'latest',
      :provider => 'git',
      :source   => source,
      :user     => user,
      :group    => user,
      :revision => 'master',
      :require  => /rbenv::plugins #{user}/,
    )
  end

  context 'with source != git' do
    let(:source) { 'something != git' }

    it 'fails informing that it is not supported yet' do
      expect {
        should contain_exec("rbenv::plugin::checkout #{user} #{plugin_name}")
      }.to raise_error(Puppet::Error, /Only git plugins are supported/)
    end
  end
end
