class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owners << Owner.create(name: params[:owner][:name])
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
      ####### bug fix
      if !params[:owner].keys.include?("owner_id")
      params[:owner]["owner_id"] = []
      end
      #######
   
      @owner = Owner.find(params[:id])
      @owner.update(params["owner"])
      if !params["pet"]["name"].empty?
        @owner.pets << Pet.create(name: params["pet"]["name"])
      end
      redirect "owners/#{@owner.id}"
  end

  patch '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end