#!/usr/bin/env bash
#
# Setup env.

debug=false

if [ "$(uname)" != "Linux" ]; then
  echo "Linux only"
  exit 1
fi

if [ "$(whoami)" = "root" ];
  then
    home="/root";
  else
    home=$HOME;
fi

dircfg=".cfg"
dirbck=".cfg_backup"
giturl="https://github.com/mpepping/cfg/archive/master.tar.gz"
ignore="deploy.sh|.git$|.gitmodule|.gitignore|README.md"

deploy_dir=$home/$dircfg
backup_dir=$home/$dirbck

md5prog() {
  if [ "$(uname)" = "Darwin" ]; then
    md5 -q "$1"
  fi
  if [ "$(uname)" = "Linux" ]; then
    md5sum "$1" | awk '{print $1}'
  fi
}

deploy_assets() {
  for asset in $assets ;
  do
    if [ ! -e "${home}/${asset}" ];
      then
        # asset does not exist, can just copy it
        echo "N [new] $home/$asset";
        if [ $debug = false ];
          then ln -s "$dircfg/$asset" "$home/$asset";
        else echo ln -s "$dircfg/$asset" "$home/$asset";
        fi
      else
        # asset is there already
        if [ -d "$home/$asset" ];
          then
            if [ -h "$home/$asset" ];
              then echo "Id[ignore dir] $home/$asset";
              else
                echo "Cd[conflict dir] $home/$asset";
                mv "$home/$asset" "$backup_dir/$asset";
                ln -s "$dircfg/$asset" "$home/$asset";
            fi
          else
            ha=$(md5prog "$home/$asset");
            ca=$(md5prog "$dircfg/$asset");
            if [ "$ha" = "$ca" ];
              # asset is exactly the same
              then
                if [ -h $home/$asset ];
                  #asset is exactly the same and as link, all good
                  then echo "I [ignore] $home/$asset";
                  else
                    #asset must be relinked
                    echo "L [re-link] $home/$asset";
                    if [ $debug = false ];
                      then
                        mv $home/$asset $backup_dir/$asset;
                        ln -s $dircfg/$asset $home/$asset;
                      else
                        echo mv $home/$asset $backup_dir/$asset;
                        echo ln -s $dircfg/$asset $home/$asset;
                    fi
                fi
              else
                # asset exist but is different, must back it up
                echo "C [conflict] $home/$asset";
                if [ $debug = false ];
                  then
                    mv $home/$asset $backup_dir/$asset;
                    ln -s $dircfg/$asset $home/$asset;
                  else
                    echo mv $home/$asset $backup_dir/$asset;
                    echo ln -s $dircfg/$asset $home/$asset;
                fi
            fi
        fi
    fi
  done
}

# create backupdir, if non existing
if [ ! -e $backup_dir ];
  then mkdir -p $backup_dir;
fi

# deploy src is non existing
if [ ! -e $dircfg ];
  then
      curl -LsO ${giturl}
      tar zxf master.tar.gz
      mkdir -p ~/bin && mv cfg-master/bin/* ~/bin/
      mv cfg-master/dotfiles "${deploy_dir}"
      rm master.tar.gz
  else
    echo "Config already deployed in $dircfg"
fi

assets=$(ls -A1 $dircfg | egrep -v $ignore | xargs);
deploy_assets
