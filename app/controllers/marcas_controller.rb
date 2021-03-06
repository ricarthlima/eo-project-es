class MarcasController < ApplicationController
  #before_action :authenticate_usuario!
  before_action :set_marca, only: [:show, :edit, :update, :destroy]

  # GET /marcas
  # GET /marcas.json
  def index
    @marcas = Marca.all
  end

  # GET /marcas/1
  # GET /marcas/1.json
  def show
    # Adicionar no histórico de pesquisa
    if usuario_signed_in?
      consulta = UsuarioBuscaMarca.where("usuario_id = " + current_usuario.id.to_s + " AND " + "marca_id = " + @marca.id.to_s)
      if consulta.size > 0
        consulta[0].dt_busca = Time.now.to_s
        consulta[0].save
      else
        UsuarioBuscaMarca.create(usuario_id: current_usuario.id, marca_id: @marca.id, dt_busca: Time.now.to_s)
      end
    end
    
  end

  # GET /marcas/new
  def new
    authorize! :menage, :all
    @marca = Marca.new
  end

  # GET /marcas/1/edit
  def edit
    authorize! :menage, :all
  end

  # POST /marcas
  # POST /marcas.json
  def create
    authorize! :menage, :all
    @marca = Marca.new(marca_params)

    respond_to do |format|
      if @marca.save
        format.html { redirect_to @marca, notice: 'Marca criada com sucesso.' }
        format.json { render :show, status: :created, location: @marca }
      else
        format.html { render :new }
        format.json { render json: @marca.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marcas/1
  # PATCH/PUT /marcas/1.json
  def update
    authorize! :menage, :all
    respond_to do |format|
      if @marca.update(marca_params)
        format.html { redirect_to @marca, notice: 'Marca atualizada com suceso.' }
        format.json { render :show, status: :ok, location: @marca }
      else
        format.html { render :edit }
        format.json { render json: @marca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marcas/1
  # DELETE /marcas/1.json
  def destroy
    authorize! :menage, :all
    @marca.destroy
    respond_to do |format|
      format.html { redirect_to marcas_url, notice: 'Marca was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marca
      @marca = Marca.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marca_params
      params.require(:marca).permit(:nome, :descricao, :class_vegan, :justificativa)
    end
end
