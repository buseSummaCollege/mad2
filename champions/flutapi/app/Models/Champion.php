<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Champion extends Model
{
    use HasFactory;

    protected $table = 'champions';

    protected $fillable = ['naam', 'klas'];
    public $timestamps = false;

    public function hobbies(){
        return $this->belongsToMany(Hobby::class, 'champion_hobby', 'champion_id', 'hobby_id', 'id', 'id');
    }

}


