require 'spec_helper'

describe IndexController do

  describe 'GET "index"' do
    before { get :index }
    it { response.should be_success }
  end

  describe 'GET "oauth"' do
    before { get :oauth }
    it { response.should be_redirect }
  end

  describe 'GET "callback"' do
    before { get :callback }
    it { response.should be_redirect }
  end

end
