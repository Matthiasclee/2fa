module TFA
  class TfasController < ActionController::Base
    def show
      @tfa = Tfa.find_by(id: params[:id])
      head 404 if @tfa.used
    end
  end
end
