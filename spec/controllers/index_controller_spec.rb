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
    before do
      session[:request_token] = {
        token: 'request_token',
        secret: 'request_secret'
      }

      request_token = stub(OAuth::RequestToken)
      access_token = stub(OAuth::AccessToken)

      OAuth::RequestToken.stub(:new).and_return(request_token)

      request_token.stub(:get_access_token).and_return(access_token)

      access_token.stub(:token).and_return('access_token')
      access_token.stub(:secret).and_return('access_secret')

      get :callback, oauth_token: 'oauth_token', oauth_verifier: 'oauth_verifier'
    end
    it { response.should be_redirect }
  end

end
