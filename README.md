# 🚀 LERO Teleportation Points

> _A sweet and simple teleportation system for your FiveM server! Make your players' lives easier with smooth garage and location teleports._ ✨

[![FiveM](https://img.shields.io/badge/FiveM-Resource-blue.svg)](https://fivem.net/)
[![Lua](https://img.shields.io/badge/Lua-5.3-purple.svg)](https://www.lua.org/)
[![ESX](https://img.shields.io/badge/Framework-ESX-orange.svg)](https://github.com/esx-framework/esx-legacy)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 💖 What's This All About?

Hey there! Welcome to **LERO Teleportation Points** - your friendly neighborhood teleportation system for FiveM! This resource makes it super easy to create teleportation points anywhere in your GTA5 world. Perfect for garages, hidden locations, VIP areas, and more!

Think of it as magical doors that take you (and your fancy cars!) from point A to point B in a blink. No more long drives through the city! 🚗💨

## ✨ Features That'll Make You Smile

- 🎯 **Pin-Point Accuracy** - Teleport exactly where you want, every time
- 🚘 **Vehicle Support** - Take your ride with you! Cars teleport seamlessly
- 👥 **Passenger Friendly** - Everyone in the vehicle gets teleported together
- 🎨 **Customizable Markers** - Make them pretty with your own colors and sizes
- 🔄 **Two-Way Teleports** - Go there, come back - super convenient!
- 🎫 **Job Restrictions** - VIP areas for special roles? You got it!
- 🏢 **IPL Loading** - Automatically loads interiors (Casino garage, anyone?)
- ⚡ **Performance Optimized** - Smooth as butter, won't lag your server
- 🎮 **Easy to Use** - Just press `E` and whoosh! You're there

## 📦 Installation (Super Easy!)

1. **Download** this resource to your FiveM server's `resources` folder
   ```
   resources/
   └── fivem_lero_telepotation_points/
   ```

2. **Add to your `server.cfg`**
   ```cfg
   ensure fivem_lero_telepotation_points
   ```

3. **Restart** your server or use:
   ```
   refresh
   start fivem_lero_telepotation_points
   ```

That's it! You're ready to teleport! 🎉

## 🎮 How to Use

Using teleportation points is as easy as 1-2-3:

1. **Walk or drive** to a teleportation marker (you'll see a purple marker!)
2. **Press `E`** when you're close enough
3. **Enjoy** your instant travel! ✨

### For Drivers
- You must be in the **driver's seat** to teleport
- All **passengers** get teleported with you
- Your **vehicle** comes along for the ride!

### For Pedestrians
- Just walk into the marker
- Press `E` to teleport
- Simple as that!

## ⚙️ Configuration

Open `config.lua` and let your creativity flow! Here's what you can customize:

### Basic Teleport Point Setup

```lua
{
    name = "My Awesome Teleport",              -- Give it a cool name
    from = vector3(x, y, z),                   -- Where the marker appears
    to = vector3(x, y, z),                     -- Where it takes you
    heading = 0.0,                             -- Which way you'll face (0-360)
    markerSize = {x = 1.5, y = 1.5, z = 1.0}, -- How big the marker is
    markerColor = {r = 255, g = 0, b = 255, a = 100}, -- Make it pretty!
    drawDistance = 50.0,                       -- How far you can see it
    interactDistance = 7,                      -- How close to activate
    twoWay = false,                            -- true = creates return point
    ipls = {},                                 -- Interior loading (if needed)
    allowedJobs = {}                           -- Restrict to specific jobs
}
```

### Pro Tips! 💡

- **Two-Way Teleports**: Set `twoWay = true` and a return point is automatically created!
- **Job Restrictions**: Add `allowedJobs = {"police", "ambulance"}` to limit access
- **Casino Garages**: Use `ipls = {"vw_casino_carpark", "vw_casino_garage"}` to load the interior
- **Color Fun**: Play with RGBA values to create unique marker colors!

## 🎨 Default Configuration

The resource comes pre-configured with Casino teleport points:
- 🎰 Casino Garage (Standard & VIP)
- 📦 Casino Loading Bay (job-restricted)
- 🎵 Casino Music Locker
- 🏨 Casino Penthouse

Feel free to modify or remove these to fit your server's needs!

## 🔧 Requirements

- ✅ **FiveM Server**
- ✅ **ESX Framework** (Legacy or any modern version)
- ❤️ **A desire to make your players happy!**

## 🤝 Support & Community

Need help? Have ideas? Found a bug? We're here for you!

- 🐛 **Issues**: [Open an issue](https://github.com/L-E-R-O/fivem_lero_telepotation_points/issues)
- 💬 **Discussions**: Share your setups and ideas!
- ⭐ **Star this repo** if you find it helpful!

## 🌟 Why You'll Love This

- **Zero Hassle**: Drop it in, configure, done!
- **Player Friendly**: Your community will thank you
- **Server Friendly**: Optimized performance
- **Developer Friendly**: Clean, commented code
- **Future Proof**: Regular updates and improvements

## 📝 License

This project is open source and available under the MIT License. Feel free to use it, modify it, and make it yours!

## 💝 A Little Thank You

Thank you for choosing LERO Teleportation Points! If this resource makes your server better, consider:
- ⭐ **Starring** this repository
- 🔄 **Sharing** it with other server owners
- 💬 **Contributing** improvements or ideas

Made with ❤️ by **LERO**

---

<div align="center">
  <sub>Happy Teleporting! 🚀✨</sub>
</div>
