ActiveAdmin.register User do
  permit_params :provider, :uid, :name, :email, :image_url
end
