package com.example.dogs.viewmodel

import android.app.Application
import android.widget.Toast
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.dogs.model.DogBreed
import com.example.dogs.model.DogDatabase
import kotlinx.coroutines.launch

class DetailViewModel(application: Application): BaseViewModel(application) {
    var dogLiveData = MutableLiveData<DogBreed>()

    fun fetch() {
        val dog = DogBreed("1", "Corgi", "15 years", "breedGroup", "bredFor", "temperament", "")
        dogLiveData.value = dog
    }

    fun fetchFromDatabase(id: Int) {
        launch {
            dogLiveData.value = DogDatabase(getApplication()).dogDao().getDog(id)
            Toast.makeText(getApplication(), "Dog retrieved from database", Toast.LENGTH_SHORT).show()
        }
    }
}