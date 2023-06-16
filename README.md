![Closed Circuit](/Source/SystemAssets/card.png)

# Closed Circuit

An unofficial port of Closed Circuit to Playdate. [Closed Circuit](https://the4thad.itch.io/closed-circuit) is an original game by [The4thAD](https://the4thad.itch.io/) made for the [Black and White Jam #8](https://itch.io/jam/black-and-white-jam-8/rate/1481421). 

> A short puzzle game where you find a way to power lights with a single 9-volt battery and a long piece of wire.

## Compilation

The `.pdx` available for download has been compiled on macOS. If you play on another system, you’ll need to recompile the game. You can do this by cloning this repository and executing the following command from the root of the project.

```sh
pdc ./Source ClosedCircuit.pdx
```

## Level Design

This project uses [LDtk](https://ldtk.io/) to recreate the original game’s level designs. You can edit `Source/Levels/world.ldtk` to modify existing levels or add new ones.

If you want to add new levels, make sure to name them in the format `Level_x` where `x` is the next available number.

## Credits

[Closed Circuit](https://the4thad.itch.io/closed-circuit) is an original Unity game by [The4thAD](https://the4thad.itch.io/).

The Playdate port was done by [Rémi Parmentier](https://github.com/HTeuMeuLeu).

Playdate is a registered trademark of [Panic](https://panic.com/).

Thanks to [NicMagnier](https://github.com/NicMagnier/) for his [PlaydateLDtkImporter](https://github.com/NicMagnier/PlaydateLDtkImporter) library. And thanks to [SquidGodDev](https://github.com/SquidGodDev) for his [LDtk video tutorial](https://www.youtube.com/watch?v=7GbUxjE9rRM).

## License

This project is under the [MIT License](LICENSE). Assets like graphics and sounds are the property of their respective owners.