require 'spec_helper'

describe 'jre7' do
  context 'on Debian' do
    context '32 bit' do
      let(:facts) { {:jre7_version => nil, :operatingsystem => 'Debian', :architecture => 'i386'} }
      it do
        should contain_package('Java 7 Update 10').with({
          'source'   => '/tmp/jre_1.7.0-10_i386.deb'
        })
      end
    end
    
    context '64 bit' do
      let(:facts) { {:jre7_version => nil, :operatingsystem => 'Debian', :architecture => 'amd64'} }
      it do
        should contain_package('Java 7 Update 10').with({
          'source'   => '/tmp/jre_1.7.0-10_amd64.deb'
        })
      end
    end
  end

  context 'on Ubuntu' do
    context '32 bit' do
      let(:facts) { {:jre7_version => nil, :operatingsystem => 'Debian', :architecture => 'i386'} }
      it do
        should contain_package('Java 7 Update 10').with({
          'source'   => '/tmp/jre_1.7.0-10_i386.deb'
        })
      end
    end
    
    context '64 bit' do
      let(:facts) { {:jre7_version => nil, :operatingsystem => 'Debian', :architecture => 'amd64'} }
      it do
        should contain_package('Java 7 Update 10').with({
          'source'   => '/tmp/jre_1.7.0-10_amd64.deb'
        })
      end
    end
  end

  context 'on CentOS' do
    context '32 bit' do
      let(:facts) { {:jre7_version => nil, :operatingsystem => 'CentOS', :architecture => 'i386'} }
      it do
        should contain_package('Java 7 Update 10').with({
          'source'   => '/tmp/jre-7u10-linux-i586.rpm'
        })
      end
    end
    
    context '64 bit' do
      let(:facts) { {:jre7_version => nil, :operatingsystem => 'CentOS', :architecture => 'x86_64'} }
      it do
        should contain_package('Java 7 Update 10').with({
          'source'   => '/tmp/jre-7u10-linux-x64.rpm'
        })
      end
    end
  end

  context 'on RedHat' do
    context '32 bit' do
      let(:facts) { {:jre7_version => nil, :operatingsystem => 'RedHat', :architecture => 'i386'} }
      it do
        should contain_package('Java 7 Update 10').with({
          'source'   => '/tmp/jre-7u10-linux-i586.rpm'
        })
      end
    end
    
    context '64 bit' do
      let(:facts) { {:jre7_version => nil, :operatingsystem => 'RedHat', :architecture => 'x86_64'} }
      it do
        should contain_package('Java 7 Update 10').with({
          'source'   => '/tmp/jre-7u10-linux-x64.rpm'
        })
      end
    end
  end
  
  context 'on Windows' do
    let(:facts) { {:jre7_version => nil, :operatingsystem => 'Windows'} }
    it do
      should contain_package('Java 7 Update 10').with({
        'source'   => 'c://temp//jre-7u10-windows-i586.exe'
      })
    end
  end

  context 'on OSX' do
    let(:facts) { {:jre7_version => nil, :operatingsystem => 'Darwin'} }
    it do
      should contain_package('Java 7 Update 10').with({
        'source'   => '/tmp/jre-7u10-macosx-x64.dmg'
      })
    end
  end
end