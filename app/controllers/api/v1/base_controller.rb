class Api::V1::BaseController < ApplicationController
  #protect_from_forgery with: :null_session

  #before_action :destroy_session
  
  
  def show
	puts 'entering show'
    render json: get_resource(params[:resource_type], params[:id])
	#render JSON.pretty_generate( json: get_resource(params[:resource_type], params[:id]) )
	#render json: JSON.pretty_generate( get_resource(params[:resource_type], params[:id]) )
  end

  # POST /api/{plural_resource_name}
  def create
	puts 'entering create....'
	puts request.body.read
	render json: create_resource(request.body.read)

	#if get_resource.save
	 # render :show, status: :created
	#else
	 # render json: get_resource.errors, status: :unprocessable_entity
	#end
  
  end
  
  def search
	query_strings = request.query_parameters.to_hash()
	search_string = ''
	puts query_strings.size
	query_strings.each do |key,value|
		puts "#{key.to_s} #{value.to_s}"
		if search_string = '' then
			search_string = "#{key.to_s}=#{value.to_s}"
		else
			search_string = search_string + '&' + "#{key.to_s}=#{value.to_s}"
		end
	end
	puts search_string
	
	render json: search_for_resource(params[:resource_type], search_string)
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  def request_params
    params.permit(:resource_type, :id)
  end
  
  private
  
end
