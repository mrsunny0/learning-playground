package com.example.dogs.view

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.dogs.R
import com.example.dogs.model.DogBreed
import kotlinx.android.synthetic.main.item_dog.view.*

// create custom adapter
class DogsListAdapter(val dogsList: ArrayList<DogBreed>): RecyclerView.Adapter<DogsListAdapter.DogViewHolder>() {

    // create the custom view
    // this will be extended on the override function onCreateViewHolder
    class DogViewHolder(var view: View) : RecyclerView.ViewHolder(view)

    // present the custom view
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DogViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.item_dog, parent, false)
        return DogViewHolder(view)
    }

    // return the
    override fun getItemCount(): Int {
        return dogsList.size
    }

    // create the conversion mechanism from the view to the data model
    override fun onBindViewHolder(holder: DogViewHolder, position: Int) {
        holder.view.name.text = dogsList[position].dogBreed
        holder.view.lifespan.text = dogsList[position].lifeSpan
    }

    // update
    fun updateDogList(newDogsList: List<DogBreed>) {
        dogsList.clear()
        dogsList.addAll(newDogsList)
        notifyDataSetChanged()
    }
}