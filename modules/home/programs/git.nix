{ pkgs, ... }: 

{

  programs.git = {
    enable = true;
    
    userName = "serenity-F";
    userEmail = "serenity-amalgam@protonmail.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
    };
  };

}
