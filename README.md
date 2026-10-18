# NixOS — Hybrid Graphics

My personal NixOS configuration for the **ASUS ROG Zephyrus G16 (GA605WI)**, featuring an AMD Ryzen AI 9 HX 370 and NVIDIA RTX 4070 Laptop GPU.

This branch is adapted from my main NixOS configuration to support a laptop with hybrid graphics.

## Hybrid Graphics

The system uses **NVIDIA PRIME Render Offload**:

- **AMD integrated GPU** — handles Hyprland, desktop applications, and everyday tasks.
- **NVIDIA RTX 4070** — runs demanding applications and games when explicitly requested.
- **Power management** — allows the NVIDIA GPU to enter a low-power state when not in use.

To launch an application using NVIDIA:

```bash
nvidia-offload <application>
```

For Steam games, use the following launch option:

```bash
nvidia-offload %command%
```

This setup keeps the desktop running on the integrated GPU while providing access to NVIDIA performance when needed.

## Configuration

- NixOS Unstable with Flakes
- Hyprland with a Lua-based configuration
- Home Manager
- ASUS laptop controls through `asusctl`
- Kitty, Waybar, Rofi, and other desktop utilities

## Notes

This configuration contains hardware-specific settings, including GPU PCI bus IDs and device configuration. These may need adjustment for other laptops.

The `main` branch contains my original desktop configuration, while `hybrid` is tailored to the Zephyrus G16.
