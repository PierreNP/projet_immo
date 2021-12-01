class UserMailer < ApplicationMailer
  default from: 'jo.travelwifi@gmail.com'
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'test' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end
  def reset_password(user)
    @user = user 
    @url = "http://localhost:3000/passwords/reset/#{user.reset_password_token}"
    mail(to: @user.email, subject: "Mot de passe oublié '")
  end 
end
