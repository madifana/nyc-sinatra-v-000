class FiguresController < ApplicationController

   get '/figures' do
     @figures = Figure.all
     erb :'figures/index'
   end

   get '/figures/new' do
     @landmarks = Landmark.all
     @titles = Title.all
     erb :'figures/new'
   end

   post '/figures' do
     @figure = Figure.create(params[:figure])
     if params[:title][:name] != ""
       @figure.titles << Title.find_or_create_by(params["title"])
     end
     if params[:landmark][:name] != ""
       @figure.landmarks << Landmark.find_or_create_by(params["landmark"])
     end
     @figure.save
     redirect '/figures'
   end

   get '/figures/:id' do
     @figure = Figure.find(params[:id])
     erb :'figures/show'
   end

   get '/figures/:id/edit' do
     @figure = Figure.find(params[:id])
     @landmarks = Landmark.all
     @titles = Title.all
     erb :'figures/edit'
   end

   post'/figures/:id' do
     @figure = Figure.find(params[:id])
     if params[:figure][:name] != ""
       @figure.name = params[:figure][:name]
     end
     if params[:title][:name] != ""
       @figure.titles << Title.find_or_create_by(params["title"])
     end
     if params[:landmark][:name] != ""
       @figure.landmarks << Landmark.find_or_create_by(params["landmark"])
     end
     @figure.save
     redirect "/figures/#{@figure.id}"
   end
 end
