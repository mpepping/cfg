#!/usr/bin/env bash

if [ $(whoami) = "root" ];
  then
    home="/root";
  else
    home=$HOME;
fi

dircfg=".config"
dirbck=".config_backup"
giturl="https://github.com/mpepping/cfg/archive/master.tar.gz"
ignore="deploy.sh|.git$|.gitmodule|.gitignore|README.md"

deploy_dir=$home/$dircfg
backup_dir=$home/$dirbck

md5prog() {
  if [ $(uname) = "Darwin" ]; then
    md5 -q $1
  fi
  if [ $(uname) = "Linux" ]; then
    md5sum $1 | awk {'print $1'}
  fi
}


deploy_assets() {
  for asset in $assets ;
  do
    if [ ! -e $home/$asset ];
      then
        #asset does not exist, can just copy it
        echo "N [new] $home/$asset";
        if [ $debug = false ];
          then ln -s $cfg_folder/$asset $home/$asset;
          else echo ln -s $cfg_folder/$asset $home/$asset;
        fi
      else
        #asset is there already
        if [ -d $home/$asset ];
          then
            if [ -h $home/$asset ];
              then echo "Id[ignore dir] $home/$asset";
              else
                echo "Cd[conflict dir] $home/$asset";
                mv $home/$asset $backup_folder/$asset;
                ln -s $cfg_folder/$asset $home/$asset;
            fi
          else
            ha=$(md5prog $home/$asset);
            ca=$(md5prog $cfg_folder/$asset);
            if [ $ha = $ca ];
              #asset is exactly the same
              then
                if [ -h $home/$asset ];
                  #asset is exactly the same and as link, all good
                  then echo "I [ignore] $home/$asset";
                  else
                    #asset must be relinked
                    echo "L [re-link] $home/$asset";
                    if [ $debug = false ];
                      then
                        mv $home/$asset $backup_folder/$asset;
                        ln -s $cfg_folder/$asset $home/$asset;
                      else
                        echo mv $home/$asset $backup_folder/$asset;
                        echo ln -s $cfg_folder/$asset $home/$asset;
                    fi
                fi
              else
                #asset exist but is different, must back it up
                echo "C [conflict] $home/$asset";
                if [ $debug = false ];
                  then
                    mv $home/$asset $backup_folder/$asset;
                    ln -s $cfg_folder/$asset $home/$asset;
                  else
                    echo mv $home/$asset $backup_folder/$asset;
                    echo ln -s $cfg_folder/$asset $home/$asset;
                fi
            fi
        fi
    fi
  done
}

if [ ! -e $backup_folder ];
  then mkdir -p $backup_folder;
fi

if [ ! -e $cfg_folder ];
  then
      curl -LsO ${giturl}
      tar zxvf cfg-master.tar.gz
      mv cfg-master ${deploy_dir}
      rm cfg-master.tar.gz
  else
    echo "Config already deployed in $cfg_folder"
fi

assets=$(ls -A1 $cfg_folder | egrep -v $ignored | xargs);
deploy_assets
