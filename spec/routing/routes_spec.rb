require 'spec_helper'

describe :routes do

  describe 'GET "/"' do
    subject { {get: '/'} }
    it { should route_to(controller: 'index', action: 'index') }
  end

  describe 'GET "/oauth"' do
    subject { {get: '/oauth'} }
    it { should route_to(controller: 'index', action: 'oauth') }
  end

  describe 'GET "/callback"' do
    subject { {get: '/callback'} }
    it { should route_to(controller: 'index', action: 'callback') }
  end

end
