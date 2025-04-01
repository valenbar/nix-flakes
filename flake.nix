{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates = {

      togo = {
        path = ./togo;
        description = "a terminal-based Todo Manager ";
      };
    };
  };
}
