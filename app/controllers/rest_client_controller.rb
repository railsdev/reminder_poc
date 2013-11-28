class RestClientController < ApplicationController
  require 'rest_client'

  def new
  end

  def create
    api_end_point = 'https://gtw.iwsinc.com/client_api/v1/' + params[:req_url]
    req = RestClient.send(params[:req_method].to_sym, api_end_point, {'Client-UUID' => params[:client_uuid]}) if ['get', 'delete'].include?(params[:req_method])
    req = RestClient.send(params[:req_method].to_sym, api_end_point, eval(params[:req_body]), {'Client-UUID' => params[:client_uuid]}) if ['post', 'put'].include?(params[:req_method])
    @resp = req
    render :action => :new
  end
end
