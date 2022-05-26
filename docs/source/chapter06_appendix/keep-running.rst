.. _keep-running-label:

Keep a program running after logoff
===================================

Shared clusters often have job schedulers to handle multiple users' job submissions. On the cloud, however, the entire server belongs to you so there's generally no need for a scheduler. 

.. note::
  Have multiple jobs? Why schedule them? Just launch multiple instances to run all of them at the same time. Running 5 instances for 1 hour costs exactly the same as running 1 instance for 5 hours, but the former approach saves you 80% of time without incurring any additional charges.

Thus, instead of using ``qsub`` (with `PBS <https://en.wikipedia.org/wiki/Portable_Batch_System>`_) or ``sbatch`` (with `Slurm <https://en.wikipedia.org/wiki/Slurm_Workload_Manager>`_), you would simply run the executable ``./geos.mp`` from the terminal. To keep the program running after logoff or internet interruption, use simple tools such as the `nohup command <https://en.wikipedia.org/wiki/Nohup>`_, `GNU screen <https://www.gnu.org/software/screen/>`_ or `tmux <https://github.com/tmux/tmux/wiki>`_. I personally like tmux as it is very easy to use and also allows advanced terminal management if needed. It is also quite useful for managing other time-consuming computations such as big data processing or training machine learning models, so worth learning.

Use nohup command (not recommended)
-----------------------------------

``nohup`` is a built-in Linux command to prevent a program from being interrupted. This works but is **not recommended** since monitoring nohup jobs is kind of a mess. Instead, use ``screen`` or ``tmux`` as detailed in the next section. I just put basic ``nohup`` commands here for record.

Start the simulation with nohup mode::

  $ nohup ./geos.mp > run.log &
  $ nohup: ignoring input and redirecting stderr to stdout

Type ``Crtl + c`` to go back to normal terminal. Use ``tail -f run.log`` to monitor the log file if necessary. Log off and re-login the server if you like.

List nohup jobs by ``ps x``::

  $ ps x
  ...
  13067 pts/0    Rl     4:56 ./geos.mp
  ...

If necessary, kill the job by its ID. In this case, it is::

  kill 13067

Use GNU Screen
--------------

The ``screen`` commmand creates terminal sessions that can persist after logoff. Here's `a nice tutorial <https://www.rc.fas.harvard.edu/resources/documentation/linux/gnu-screen/>`_ offered by Harvard Research Computing.

Start a screen session with any name you like ::

  $ screen -S run-geoschem

Inside the screen session, run the model as usual::

  $ ./geos.mp | tee run.log

(Here I use ``tee`` to print model log to both the terminal screen and a file.)

Type ``Ctrl + a``, and then type ``d``, to **detach** from the current session. You will be back to the normal terminal but the model is still running inside that detached session. You can log off the server and re-login if you like.

List existing sessions by::

  $ screen -ls
  There is a screen on:
  	13279.run-geoschem	(03/12/2018 12:25:39 AM)	(Detached)
  1 Socket in /var/run/screen/S-ubuntu.

Resume that session by ::

  screen -x run-geoschem

Use tmux (recommended)
----------------------

The ``tmux`` command behaves almost the same as ``screen`` for single-panel sessions. But it is also useful for splitting one terminal window into multiple panels (tons of quick tutorials online, say `this <http://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/>`_, `and this <https://danielmiessler.com/study/tmux/>`_). ``screen`` also does terminal splitting but is not as convenient as tmux.

Start a new session by ::

  $ tmux

Inside the session, run the model as usual, just like in the ``screen`` session::

  $ ./geos.mp | tee run.log

Type ``Ctrl + b``, and then type ``d``, to **detach** from the current session. Use ``tmux ls`` to list existing sessions and ``tmux a`` (shortcut for ``tmux attach``) to resume the session.

To handle multiple sessions, use ``tmux new -s session_name`` to create a session with a name and ``tmux a -t session_name`` to resume that specific session.

