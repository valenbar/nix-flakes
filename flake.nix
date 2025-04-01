{
  description = "A collection of flake templates";

  outputs = { self }: {

    togo = {
      path = ./togo;
      description = "a terminal-based Todo Manager ";
    };

  };
}
