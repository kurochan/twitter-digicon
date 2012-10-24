class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def self.consumer
    OAuth::Consumer.new(
      '7jU6c4oblMyhbOQ50IMAvQ',
      'BxAttdV0Tf2l22lWdrHeDh3K1tMSr5NEgqXBe03BrA',
      :site => "http://api.twitter.com"
    )
  end

end
