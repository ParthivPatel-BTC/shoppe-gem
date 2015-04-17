module Shoppe
  class UsersController < Shoppe::ApplicationController

    before_filter { @active_nav = :users }
    before_filter { params[:id] && @user = Shoppe::User.find(params[:id]) }
    before_filter(:only => [:create, :update, :destroy]) do
      if Shoppe.settings.demo_mode?
        raise Shoppe::Error, t('shoppe.users.demo_mode_error')
      end
    end

    def index
      @users = Shoppe::User.all
    end

    def new
      @user = Shoppe::User.new
    end

    def create
      @user = Shoppe::User.new(safe_params)
      if @user.save
        subscribe_to_mailchimp
        redirect_to :users, :flash => {:notice => t('shoppe.users.create_notice') }
      else
        render :action => "new"
      end
    end

    def edit
    end

    def update
      if @user.update(safe_params)
        redirect_to [:edit, @user], :flash => {:notice => t('shoppe.users.update_notice') }
      else
        render :action => "edit"
      end
    end

    def destroy
      raise Shoppe::Error, t('shoppe.users.self_remove_error') if @user == current_user
      @user.destroy
      redirect_to :users, :flash => {:notice => t('shoppe.users.destroy_notice') }
    end

    private

    def safe_params
      params[:user].permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
    end

    def subscribe_to_mailchimp
      begin
        subscription_detail = @mailchimp.lists.subscribe('78ceb1aa8b', "email"=> safe_params['email_address'])
      rescue Mailchimp::ListAlreadySubscribedError

      rescue Mailchimp::ListDoesNotExistError, Mailchimp::Error => ex
        flash[:error] = "The list could not be found"
      end
      begin
        @subscribe = @mailchimp.lists.batch_subscribe('78ceb1aa8b',
                                                      [{ "EMAIL" => subscription_detail,
                                                         :EMAIL_TYPE => 'html',
                                                         :merge_vars => { "FIRSTNAME" => safe_params['first_name'],
                                                                          "LASTNAME" => safe_params['last_name'],
                                                                          "STATUS" => "Subscribed",
                                                                          "LBOOKCNTRY" => "United States"}}],
                                                      false, true, false)
        flash[:notice] = 'Subscribed Successfuly'
      rescue Mailchimp::Error => ex
        flash[:error] = @subscribe['errors']
      end
    end
  end
end
