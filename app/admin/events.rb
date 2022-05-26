ActiveAdmin.register Event do
  permit_params :owner_id, :name, :place, :start_at, :end_at, :content

  form do |f|
    f.inputs do
      f.input :owner_id
      f.input :name
      f.input :place
      f.input :start_at
      f.input :end_at
      f.input :content
    end
    f.actions
  end
end
