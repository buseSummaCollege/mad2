<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Hobby extends Model
{
    use HasFactory;

    protected $table = 'hobbies';
    protected $fillable = ['naam'];
    public $timestamps = false;

    public function champions(){
        return $this->belongsToMany(Champion::class, 'champion_hobby', 'hobby_id', 'champion_id', 'id', 'id');
    }

}


