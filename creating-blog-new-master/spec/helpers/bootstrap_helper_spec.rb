require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do
  describe '#bootstrap_flash' do
    subject { helper.bootstrap_flash }

    context 'flashデータなしの時' do
      it { is_expected.to eq '' }
    end

    [{ type: :danger,  alert_type: :danger,  value: 'デンジャー' },
     { type: :info,    alert_type: :info,    value: 'インフォメーション' },
     { type: :success, alert_type: :success, value: 'サクセス' },
     { type: :warning, alert_type: :warning, value: 'ワーニング' },
     { type: :notice,  alert_type: :success, value: 'ノティス' },
     { type: :alert,   alert_type: :danger,  value: 'アラート' },
     { type: :error,   alert_type: :danger,  value: 'エラー' }].each do |params|
      context "flash[:#{params[:type]}]データありの時" do
        before { flash[params[:type]] = params[:value] }
        it do
          is_expected.to eq(
            helper.tag.div(class: "alert alert-dismissible fade show alert-#{params[:alert_type]} mb-1") do
              helper.concat tag.button(raw('&times;'), class: 'close', data: { dismiss: 'alert' })
              helper.concat params[:value]
            end
          )
        end
      end
    end
  end
end
