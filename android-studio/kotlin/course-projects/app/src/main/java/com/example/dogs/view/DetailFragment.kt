package com.example.dogs.view

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders

import com.example.dogs.R
import com.example.dogs.model.DogBreed
import com.example.dogs.util.getProgressDrawable
import com.example.dogs.util.loadImage
import com.example.dogs.viewmodel.DetailViewModel
import kotlinx.android.synthetic.main.fragment_detail.*
import kotlinx.android.synthetic.main.item_dog.view.*

/**
 * A simple [Fragment] subclass.
 */
class DetailFragment : Fragment() {

    private var dogUuid = 0;
    private lateinit var viewModel: DetailViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_detail, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        arguments?.let {
            dogUuid = DetailFragmentArgs.fromBundle(it).dogUuid
        }

        // create viewModel
        viewModel = ViewModelProviders.of(this).get(DetailViewModel::class.java)
        viewModel.fetchFromDatabase(dogUuid)

        // observe the view Model
        observeViewModel()
    }
    
    fun observeViewModel() {
        // observe data changes
        viewModel.dogLiveData.observe(this, Observer { dog ->
            dog?.let {
                context?.let {
                    dogImage.loadImage(dog.imageUrl, getProgressDrawable(it))
                }
                dogName.text = dog.dogBreed
                dogLifeSpan.text = dog.lifeSpan
                dogPurpose.text = dog.bredFor
                dogTemperament.text = dog.temperament
            }
        })
    }

}
