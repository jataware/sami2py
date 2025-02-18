Sample Workflow
===============

In iPython, run:

.. code:: python

  import sami2py

If this is your first import of sami2py, it will remind you to set the top level
directory that will hold the model output.  This should be a string containing
the path to the directory you want to store the data in, such as
``path='/Users/me/data/sami2py'`` or ``path='C:\home\data'``.  This should be
outside the main code directory, so model output files are not confused with
model inputs or source code.  If you are using Git, it will also ensure that
Git does not try to store your local code runs within the repository.

.. code:: python

  sami2py.utils.set_archive_dir(path=path)

sami2py will raise an error if this is not done before trying to run the model.

.. code:: python

  sami2py.run_model(tag='run_name', lon=0, year=2012, day=210)

Note that the sami2 model runs for 24 hours of simulated time to clear
transients, then begins to output data. For the default options (24 hours of
prep, 24 hours of output, output every 15 minutes), this may take 10-20 minutes
to run, depending on the user setup.

Now load the resultant data:

.. code:: python

  ModelRun = sami2py.Model(tag='run_name', lon=0, year=2012, day=210)

The data is stored as `ModelRun.data`, which is an `xarray.Dataset`.
Information about the run is stored as 'ModelRun.MetaData', which is a
human-readable dictionary of the namelist.

The MetaData can be accessed directly via the dictionary, or through the
``__repr__``.  Typing

.. code:: python

  ModelRun

yields

.. code:: python

  Model Run Name = test
  Day 256, 1999
  Longitude = 256 deg
  2 time steps from  0.1 to  0.1 UT
  Ions Used: H+, O+, NO+, O2+, He+, N2+

  Solar Activity
  --------------
  F10.7: 120.0 sfu
  F10.7A: 120.0 sfu
  ap: 0

  Component Models Used
  ---------------------
  Neutral Atmosphere: NRLMSISe-2000
  Winds: HWM-14
  Photoproduction: EUVAC
  ExB Drifts: Fejer-Scherliess

  No modifications to empirical models


Options
-------

For applications that require neutral density data (such as the `growin
<https://github.com/JonathonMSmith/growin>`_` package), you can tell sami2 to
output neutral parameters alongside the ions.  Note that the coupling between
ions and neutrals is one way (neutrals drive ions), the neutral values are not
expected to change from the version initialized by MSIS and scaled within the
initialization routines in sami2.

.. code:: python

  sami2py.run_model(tag='run_name', lon=0, year=2012, day=210, outn=True)


Saving as a netCDF4
-------------------

Once loaded, you have the option of saving your output as a netCDF4.  The
resulting file can then be loaded via xarray or pysatModels.  All metadata
about the model run (including the options used to generate the file) are saved
as attributes within the netCDF4 object.

.. code:: python

  ModelRun.to_netcdf('your_filename.nc')

Full description coming soon
