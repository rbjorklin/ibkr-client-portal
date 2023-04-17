ibkr-client-portal
==================

.. image:: https://github.com/rbjorklin/ibkr-client-portal/actions/workflows/build.yaml/badge.svg

.. contents::
   :local:

Introduction
------------

This repo exists to fill my own need of running `Interactive Brokers Client Portal API`_.

There are some key modifications made to the init script and related config file, namely:

* Allow access from all RFC1918_ subnets
* Fix config file logic as it seems broken out-of-the-box
* Add Jolokia jar to enable exposing metrics
* Introduce `$JAVA_OPTS` to allow for easy customization

Customization
-------------

* One might want to change the default GC to improve latency to reduce the chance
  of missed executions due to unexpected delays in order execution.
* It is generally a good idea to set an explicit limit to Java memory usage using the ``-Xmx`` option.
* To provide some insight into the performance of the Client Portal it is possible to hook up Jolokia_.
  To make the metrics exposed by Jolokia_ available in a more easily digestible
  format one can use the included `jolokia-exporter.yaml <jolokia-exporter.yaml>`_ together with jolokia_exporter_ for Prometheus consumption.

Example: ``JAVA_OPTS="-javaagent:/jolokia-jvm.jar=host=0.0.0.0 -XX:+UseZGC -Xmx128m"``

License
-------

This project uses the 0BSD_ license.
``SPDX-License-Identifier: 0BSD``

.. _0BSD: https://spdx.org/licenses/0BSD.html
.. _Interactive Brokers Client Portal API: https://www.interactivebrokers.com/en/trading/ib-api.php#client-portal-api
.. _RFC1918: https://en.wikipedia.org/wiki/Private_network
.. _Jolokia: https://jolokia.org
.. _jolokia_exporter: https://github.com/aklinkert/jolokia_exporter
