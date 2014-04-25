node default {

  stage {
    "one": ;
    "two": ;
    "three": ;
  }

  class {
    "base"    : stage => "one";
    "drush"  : stage => "two";
    "phpcgi"  : stage => "two";
    "phpenv"   : stage => "two";
    "mysql"   : stage => "two";
    "nginx"  : stage => "two";
    "commerce_kickstart"  : stage => "three";
  }
  
  Stage["one"] -> Stage["two"] -> Stage["three"]

}