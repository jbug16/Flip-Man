// Assign sToy1–sToy4 using room imageIndex (0,1,2,4 from editor); one of each per level
var _idx = min(image_index, 3);
var _sprites = [sToy1, sToy2, sToy3, sToy4];
sprite_index = _sprites[_idx];
image_index = 0;
image_xscale = 0.6;
image_yscale = 0.6;