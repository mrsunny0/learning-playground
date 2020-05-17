package com.example.dogs.view

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.example.dogs.R
import com.example.dogs.databinding.ItemDogBinding
import com.example.dogs.model.DogBreed
import com.example.dogs.util.getProgressDrawable
import com.example.dogs.util.loadImage
import kotlinx.android.synthetic.main.item_dog.view.*

// create custom adapter
class DogsListAdapter(val dogsList: ArrayList<DogBreed>): RecyclerView.Adapter<DogsListAdapter.DogViewHolder>(), DogClickListener {

    // create the custom view
    // this will be extended on the override function onCreateViewHolder
    // class DogViewHolder(var view: View) : RecyclerView.ViewHolder(view)
    class DogViewHolder(var view: ItemDogBinding): RecyclerView.ViewHolder(view.root)

    // present the custom view
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DogViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        // val view = inflater.inflate(R.layout.item_dog, parent, false)
        val view = DataBindingUtil.inflate<ItemDogBinding>(inflater, R.layout.item_dog, parent, false)
        return DogViewHolder(view)
    }

    // return the number of rows
    override fun getItemCount(): Int {
        return dogsList.size
    }

    // create the conversion mechanism from the view to the data model
    override fun onBindViewHolder(holder: DogViewHolder, position: Int) {

        // data binding occurs, by passing the literal data model class
        holder.view.dog = dogsList[position]
        holder.view.listener = this

//        holder.view.name.text = dogsList[position].dogBreed
//        holder.view.lifespan.text = dogsList[position].lifeSpan
//        holder.view.setOnClickListener {
//
//            // pass the argument variable to the view
//            val action = ListFragmentDirections.actionDetailFragment()
//            action.dogUuid = dogsList[position].uuid
//            Navigation.findNavController(it).navigate(action)
//        }
//
//        holder.view.imageView.loadImage(dogsList[position].imageUrl, getProgressDrawable(holder.view.imageView.context))
    }

    override fun onDogClicked(v: View) {
        val uuid = v.dogId.text.toString().toInt()
        val action = ListFragmentDirections.actionDetailFragment()
        action.dogUuid = uuid
        Navigation.findNavController(v).navigate(action)
    }

    // update
    fun updateDogList(newDogsList: List<DogBreed>) {
        dogsList.clear()
        dogsList.addAll(newDogsList)
        notifyDataSetChanged()
    }
}