require 'spec_helper'

describe IndexController do

  describe 'GET "index"' do
    context 'session not have oauth_token' do
      before { get :index }

      it 'response should be success' do
        response.should be_success
      end
    end

    context 'session have oauth_token' do
      before do
        session[:oauth] = {
          token: 'oauth_token',
          secert: 'oauth_secret'
        }

        @tweets = []
        20.times do |i|
          @tweets << {
            'id' => i,
            'text' => "test tweet #{i}"
          }
        end

        access_token = stub(OAuth::AccessToken)
        rubytter = stub(OAuthRubytter)

        OAuth::AccessToken.stub(:new).and_return(access_token)

        OAuthRubytter.stub(:new).and_return(rubytter)

        rubytter.stub(:friends_timeline).and_return(@tweets)

        get :index
      end

      it 'assigns @tweets should == rubytter.friends_timeline' do
        assigns(:tweets).should == @tweets
      end
    end
  end

  describe 'GET "oauth"' do
    before do
      consumer = stub(OAuth::Consumer)
      request_token = stub(OAuth::RequestToken)

      IndexController.stub(:consumer).and_return(consumer)

      consumer.stub(:get_request_token).and_return(request_token)

      request_token.stub(:token).and_return('request_token')
      request_token.stub(:secret).and_return('request_secret')

      authorize_url = 'http://twitter.com/oauth/authorize?oauth_token=oauth_token'
      request_token.stub(:authorize_url).and_return(authorize_url)

      get :oauth
    end

    it 'response should be redirect' do
      response.should be_redirect
    end

    it 'session should have request_token' do
      request.session[:request_token].should_not == nil
    end
  end

  describe 'GET "callback"' do
    context 'params have oauth_token and oauth_verifier' do
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

      it 'response should be redirect' do
        response.should be_redirect
      end

      it 'session should have oauth_token' do
        request.session[:oauth].should_not == nil
      end
    end
  end

end
