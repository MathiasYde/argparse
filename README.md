# argparse
Parse LÖVE2D arguments into an easy to use table

# How does it work?
Simply require ``argparse.lua`` file in your project and pass your args from ``love.load(args)``

```lua
local argparse = require("argparse")

function love.load(args)
    args = argparse(args)
end
```

Then run your project from the terminal
```bash
love . --ip="127.0.0.1" --port=25505 --autoreconnect=false
```

Argparse will generate an easy to use table like this
```lua
{
    ip="127.0.0.1",
    port=25505,
    autoreconnect=false
}
```

# Is this a perfect solution?
No, argparse is still not able to handle every situtation and still missing critical features. This is more meant for a simple solution to handle command line arguments without too much hassle.

# Can I help make it better?
Yes, submit a pull request and I might merge it if it improves the solution.

# License
This library is free software; you can redistribute it and/or modify it under the terms of the MIT license. See LICENSE for details.
