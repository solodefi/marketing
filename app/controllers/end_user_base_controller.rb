# This class is intended to be a superclass from which
# the other (end-user related) controller classes inherit
class EndUserBaseController < ApplicationController
	before_filter :authenticate_user!
end
