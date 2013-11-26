class RestClientController < ApplicationController
  require 'rest_client'
  
  def new
  end

  def create
    req = RestClient.send(params[:req_method].to_sym, params[:req_url], {'Client-UUID' => params[:client_uuid]}) if ['get', 'delete'].include?(params[:req_method])
    req = RestClient.send(params[:req_method].to_sym, params[:req_url], eval(params[:req_body]), {'Client-UUID' => params[:client_uuid]}) if ['post', 'put'].include?(params[:req_method])
    @resp = req
    render :action => :new
  end
end
