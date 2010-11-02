module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end

  def current_user=(user)   # SETTER method
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)    # *array - um ein Array an eine Funktion zu übergeben, die X>1 Argumente erwartet
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]   # Workaround, da ein Array erwartet wird, die Cookie-Methode aber evtl. nur nil zurückgibt
    end

end

