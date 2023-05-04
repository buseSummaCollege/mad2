<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('functies', function (Blueprint $table) {
            $table->tinyInteger('id')->autoIncrement();
            $table->string('naam', 20)->nullable(false)->unique();
        });
    }
    
    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('functies');
    }
};
