class FriendshipsController < ApplicationController
  # GET /friendships
  # GET /friendships.xml
  def index
    @friendships = Friendship.all
    @users = User.all
    @friendships_full = @friendships.collect { |f| { id: f.id, user_1: f.user_1.name, user_2: f.user_2.name } } 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friendships_full }
      format.json { render :json => @friendships_full }
    end
  end

  def jit_output
    @friendships = Friendship.all
    @users = User.all
    @friendships_full = @friendships.collect { |f| { nodeTo: f.user_1.name, nodeFrom: f.user_2.name } }
    respond_to do |format|
      format.json { render :json => { adjacencies: @friendships_full } }
    end
  end

  def network_map
  end

  def a
    @friendships = Friendship.all
    @users = User.all
    @friendships_full = @friendships.collect { |f| { nodeTo: f.user_1.name, nodeFrom: f.user_2.name } }
  end

  def graphviz_map
    @friendships = Friendship.all.collect{|f| f.user_1_id < f.user_2_id ? [ f.user_1_id, f.user_2_id ] : [ f.user_2_id, f.user_1_id ]}.uniq
    @users = User.all
    File.open("#{Rails.root}/tmp/graphviz.dot", "w") do |f|
        f.write("digraph {")
        @friendships.each do |friendship|
            f.write("\"#{friendship.user_1.name}\"--\"#{friendship.user_2.name}\"")
        end
        f.write("}")
    end
    `dot -Tgif < "#{Rails.root}/tmp/graphviz.dot" > "#{Rails.root}/public/images/graphviz.gif"`
  end

  # GET /friendships/1
  # GET /friendships/1.xml
  def show
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friendship }
    end
  end

  # GET /friendships/new
  # GET /friendships/new.xml
  def new
    @friendship = Friendship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friendship }
    end
  end

  # GET /friendships/1/edit
  def edit
    @friendship = Friendship.find(params[:id])
  end

  # POST /friendships
  # POST /friendships.xml
  def create
    @friendship = Friendship.new(params[:friendship])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to(@friendship, :notice => 'Friendship was successfully created.') }
        format.xml  { render :xml => @friendship, :status => :created, :location => @friendship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @friendship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friendships/1
  # PUT /friendships/1.xml
  def update
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      if @friendship.update_attributes(params[:friendship])
        format.html { redirect_to(@friendship, :notice => 'Friendship was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @friendship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.xml
  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to(friendships_url) }
      format.xml  { head :ok }
    end
  end
end
