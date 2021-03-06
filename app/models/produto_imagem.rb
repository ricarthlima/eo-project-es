class ProdutoImagem < ApplicationRecord
    has_attached_file :cover, default_url: "/images/logo.png" ,
    :path => ':rails_root/public/images/produto_imagem/:id.:extension',
    :url => '/images/produto_imagem/:id.:extension'
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
    
    
    # has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/logo.png" ,
    # :path => ':rails_root/public/images/produto_imagem/:id-:basename-:style.:extension',
    # :url => '/images/produto_imagem/:id-:basename-:style.:extension'
    # validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
end
