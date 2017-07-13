require 'spec_helper'

describe 'mailscanner' do

  context 'when using default parameters' do
    context 'on a RedHat-based OS' do

      #let :facts do
      #  {
      #    :kernel                 => 'Linux',
      #    :osfamily               => 'RedHat',
      #    :operatingsystem        => 'CenHat',
      #    :operatingsystemrelease => '7',
      #  }
      #end

      it { is_expected.to contain_class('mailscanner::install') }
    end

  end


end
