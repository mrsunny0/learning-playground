package com.example.dogs.view

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.Navigation

import com.example.dogs.R
import kotlinx.android.synthetic.main.fragment_detail.*
import kotlinx.android.synthetic.main.fragment_list.*

/**
 * A simple [Fragment] subclass.
 */
class DetailFragment : Fragment() {

    private var dogUuid = 0;

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
            textView3.text = dogUuid.toString()
        }

        buttonDetails.setOnClickListener {
            val action = DetailFragmentDirections.actionListFragment()
            Navigation.findNavController(it).navigate(action)
        }
    }

}
