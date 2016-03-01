class ClientsController < ApplicationController
  def index
    @all_clients = Client.all
  end

  def new
    @client = Client.new
    @all_workers = Worker.all
  end

  def show
    id = params[:id]
    @client = Client.find(id)
  end

  def create
    @client = Client.new(client_params)
    @all_workers = Worker.all
    if @client.save
      update_workers(@client)
      redirect_to district_client_path(params[:district_id], @client)
    else
      render "new"
    end
  end

  def edit
    id = params[:id]
    @client = Client.find(id)
    @all_workers = Worker.all
  end

  def update
    id = params[:id]
    @client = Client.find(id)
    @client.update(client_params)
    update_workers(@client)
    if @client.save
      redirect_to district_client_path(params[:district_id], @client)
    else
      @all_workers = Worker.all
      render "edit"
    end
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :primary_phone)
  end
end