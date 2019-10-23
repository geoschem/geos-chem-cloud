#!/bin/bash

#===============================================================================
# This script was created by gcpy.aws.s3_script_create, w/ minor manual edits.
#
# Use this to download 1 day of data for 2016-07-01 from the s3://gcgrid
# bucket to the EBS volume attached to your cloud instance.  This is useful
# for creating an AMI with 1 day of data for tutorial purposes.
#     -- GEOS-Chem Support Team (23 Oct 2019)
#===============================================================================

# ------ these commands were added manually (bmy, 10/23/19) --------------------
if [[ !(-f /home/ubuntu/ExtData/GEOSCHEM_RESTARTS/v2018-11/initial_GEOSChem_rst.4x5_standard.nc) ]]; then aws s3 cp --request-payer=requester s3:/gcgrid//GEOSCHEM_RESTARTS/v2018-11/initial_GEOSChem_rst.4x5_standard.nc /home/ubuntu/ExtData/GEOSCHEM_RESTARTS/v2018-11/; fi

if [[ !(-f /home/ubuntu/ExtData/CHEM_INPUTS/Olson_Land_Map_201203/Olson_2001_Drydep_Inputs.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/CHEM_INPUTS/Olson_Land_Map_201203/Olson_2001_Drydep_Inputs.nc /home/ubuntu/ExtData/CHEM_INPUTS/Olson_Land_Map_201203/; fi

if [[ !(-d /home/ubuntu/ExtData/CHEM_INPUTS/FAST_JX/v2019-06) ]]; then aws s3 cp --request-payer=requester --recursive s3://gcgrid/CHEM_INPUTS/FAST_JX/v2019-06/ /home/ubuntu/ExtData/CHEM_INPUTS/FAST_JX/v2019-06; fi

if [[ !(-d /home/ubuntu/ExtData/CHEM_INPUTS/FastJ_201204) ]]; then aws s3 cp --request-payer=requester --recursive s3://gcgrid/CHEM_INPUTS/FastJ_201204 /home/ubuntu/ExtData/CHEM_INPUTS/FastJ_201204; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/VOLCANO/v2019-08/2016/07/so2_volcanic_emissions_Carns.20160701.rc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/VOLCANO/v2019-08/2016/07/so2_volcanic_emissions_Carns.20160701.rc /home/ubuntu/ExtData/HEMCO/VOLCANO/v2019-08/2016/07/; fi

if [[ !(-d /home/ubuntu/ExtData/CHEM_INPUTS/UCX_201904) ]]; then aws s3 cp --request-payer=requester --recursive s3://gcgrid/CHEM_INPUTS/UCX_201904 /home/ubuntu/ExtData/CHEM_INPUTS/UCX_201904; fi

if [[ !(-d /home/ubuntu/ExtData/CHEM_INPUTS/UCX_201403) ]]; then aws s3 cp --request-payer=requester --recursive s3://gcgrid/CHEM_INPUTS/UCX_201403 /home/ubuntu/ExtData/CHEM_INPUTS/UCX_201403; fi
# ------------------------------------------------------------------------------

if [[ !(-f /home/ubuntu/ExtData/CHEM_INPUTS/Linoz_200910/Linoz_March2007.dat) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/CHEM_INPUTS/Linoz_200910/Linoz_March2007.dat /home/ubuntu/ExtData/CHEM_INPUTS/Linoz_200910/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2011/01/GEOSFP.20110101.CN.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2011/01/GEOSFP.20110101.CN.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2011/01/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A1.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A1.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A3cld.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A3cld.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A3dyn.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A3dyn.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A3mstC.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A3mstC.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A3mstE.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.A3mstE.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.I3.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160701.I3.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A1.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A1.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A3cld.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A3cld.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A3dyn.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A3dyn.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A3mstC.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A3mstC.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A3mstE.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.A3mstE.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.I3.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/GEOSFP.20160702.I3.4x5.nc /home/ubuntu/ExtData/GEOS_4x5/GEOS_FP/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/ACET/v2014-07/ACET_seawater.generic.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/ACET/v2014-07/ACET_seawater.generic.1x1.nc /home/ubuntu/ExtData/HEMCO/ACET/v2014-07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/AEIC/v2015-01/AEIC.47L.gen.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/AEIC/v2015-01/AEIC.47L.gen.1x1.nc /home/ubuntu/ExtData/HEMCO/AEIC/v2015-01/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/AFCID/v2018-04/PM25FINE_ECLIPSE_2015.geos.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/AFCID/v2018-04/PM25FINE_ECLIPSE_2015.geos.2x25.nc /home/ubuntu/ExtData/HEMCO/AFCID/v2018-04/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/AFCID/v2018-04/PM25FINE_IITB_2013.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/AFCID/v2018-04/PM25FINE_IITB_2013.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/AFCID/v2018-04/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/AFCID/v2018-04/PM25FINE_MEIC_2012.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/AFCID/v2018-04/PM25FINE_MEIC_2012.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/AFCID/v2018-04/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/ALD2/v2017-03/ALD2_seawater.geos.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/ALD2/v2017-03/ALD2_seawater.geos.2x25.nc /home/ubuntu/ExtData/HEMCO/ALD2/v2017-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/ALD2/v2017-03/resp.geos.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/ALD2/v2017-03/resp.geos.2x25.nc /home/ubuntu/ExtData/HEMCO/ALD2/v2017-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/APEI/v2016-11/APEI.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/APEI/v2016-11/APEI.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/APEI/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc /home/ubuntu/ExtData/HEMCO/AnnualScalar/v2014-07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/BIOFUEL/v2014-07/biofuel.geos.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/BIOFUEL/v2014-07/biofuel.geos.4x5.nc /home/ubuntu/ExtData/HEMCO/BIOFUEL/v2014-07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/BROMINE/v2015-02/BromoCarb_Season.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/BROMINE/v2015-02/BromoCarb_Season.nc /home/ubuntu/ExtData/HEMCO/BROMINE/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/BROMINE/v2015-02/Bromocarb_Liang2010.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/BROMINE/v2015-02/Bromocarb_Liang2010.nc /home/ubuntu/ExtData/HEMCO/BROMINE/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/C2H6_2010/v2019-06/C2H6_global_anth_biof.201007.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/C2H6_2010/v2019-06/C2H6_global_anth_biof.201007.4x5.nc /home/ubuntu/ExtData/HEMCO/C2H6_2010/v2019-06/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/ALD2-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/ALD2-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/ALK4_butanes-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/ALK4_butanes-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/ALK4_hexanes-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/ALK4_hexanes-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/ALK4_pentanes-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/ALK4_pentanes-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/BC-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/BC-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/BENZ-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/BENZ-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/C2H6-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/C2H6-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/C3H8-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/C3H8-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/CH2O-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/CH2O-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/CO-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/CO-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/EOH-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/EOH-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/HCOOH-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/HCOOH-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/MEK-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/MEK-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/NH3-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/NH3-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/NO-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/NO-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/OC-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/OC-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/PRPE-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/PRPE-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/SO2-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/SO2-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/TOLU-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/TOLU-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/XYLE-em-anthro_CMIP_CEDS_2014.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/CEDS/v2018-08/2014/XYLE-em-anthro_CMIP_CEDS_2014.nc /home/ubuntu/ExtData/HEMCO/CEDS/v2018-08/2014/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-adhoc-oil-refining-2006-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-adhoc-oil-refining-2006-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-cars-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-cars-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-charcoal-production-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-charcoal-production-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-charcoal-use-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-charcoal-use-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-gas-flares-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-gas-flares-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-generator-use-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-generator-use-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-household-crop-residue-use-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-household-crop-residue-use-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-household-fuelwood-use-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-household-fuelwood-use-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-kerosene-use-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-kerosene-use-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-motorcycles-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-motorcycles-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/DICE-Africa-other-fuelwood-use-2013-v01-4Oct2016.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DICE_Africa/v2016-10/DICE-Africa-other-fuelwood-use-2013-v01-4Oct2016.nc /home/ubuntu/ExtData/HEMCO/DICE_Africa/v2016-10/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/DMS/v2015-07/DMS_lana.geos.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/DMS/v2015-07/DMS_lana.geos.1x1.nc /home/ubuntu/ExtData/HEMCO/DMS/v2015-07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv42/v2015-02/NO/EDGAR_hourly_NOxScal.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv42/v2015-02/NO/EDGAR_hourly_NOxScal.nc /home/ubuntu/ExtData/HEMCO/EDGARv42/v2015-02/NO/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.ENG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.ENG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.IND.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.IND.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.POW.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.POW.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.SWD.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.SWD.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.TNG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.BC.TNG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.ENG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.ENG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.IND.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.IND.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.POW.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.POW.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.PPA.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.PPA.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.SWD.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.SWD.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.TNG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.CO.TNG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.AGR.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.AGR.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.ENG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.ENG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.IND.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.IND.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.POW.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.POW.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.PPA.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.PPA.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.SOL.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.SOL.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.SWD.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.SWD.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.TNG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NH3.TNG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.AGR.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.AGR.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.ENG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.ENG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.IND.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.IND.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.POW.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.POW.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.PPA.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.PPA.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.SWD.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.SWD.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.TNG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.NOx.TNG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.ENG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.ENG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.IND.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.IND.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.POW.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.POW.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.SWD.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.SWD.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.TNG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.OC.TNG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.ENG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.ENG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.IND.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.IND.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.POW.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.POW.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.PPA.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.PPA.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.SWD.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.SWD.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.TNG.0.1x0.1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.SO2.TNG.0.1x0.1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/EDGAR_v43.Seasonal.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/EDGARv43/v2016-11/EDGAR_v43.Seasonal.1x1.nc /home/ubuntu/ExtData/HEMCO/EDGARv43/v2016-11/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GEIA/v2014-07/GEIA_monthscal.generic.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GEIA/v2014-07/GEIA_monthscal.generic.1x1.nc /home/ubuntu/ExtData/HEMCO/GEIA/v2014-07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GFED4/v2015-10/2016/GFED4_gen.025x025.201607.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GFED4/v2015-10/2016/GFED4_gen.025x025.201607.nc /home/ubuntu/ExtData/HEMCO/GFED4/v2015-10/2016/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.ACET.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.ACET.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.ACTA.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.ACTA.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.ALD2.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.ALD2.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.ALK4.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.ALK4.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.C2H6.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.C2H6.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.C3H8.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.C3H8.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CCl4.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CCl4.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CF2Cl2.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CF2Cl2.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CF2ClBr.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CF2ClBr.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CFC113.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CFC113.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CFC114.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CFC114.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CFC115.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CFC115.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CFCl3.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CFCl3.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CH2O.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CH2O.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CH3CCl3.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CH3CCl3.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CH3Cl.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CH3Cl.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CH4.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CH4.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.CO.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.CO.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.Cl.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.Cl.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.Cl2.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.Cl2.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.Cl2O2.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.Cl2O2.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.ClO.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.ClO.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.EOH.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.EOH.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.GLYC.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.GLYC.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.GLYX.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.GLYX.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.H2402.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.H2402.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.H2O.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.H2O.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.H2O2.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.H2O2.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HAC.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HAC.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HCFC141b.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HCFC141b.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HCFC142b.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HCFC142b.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HCFC22.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HCFC22.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HCOOH.geos5.2x25.20170108.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HCOOH.geos5.2x25.20170108.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HCl.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HCl.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HNO2.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HNO2.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HNO3.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HNO3.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HNO4.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HNO4.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.HOCl.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.HOCl.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.PMN.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.PMN.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.IPMN.geos5.2x25.nc) ]]; then ln -s /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.PMN.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.IPMN.geos.2x25.nc; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.NPMN.geos5.2x25.nc) ]]; then ln -s /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.PMN.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.NPMN.geos.2x25.nc; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.ISN1.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.ISN1.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.ISOP.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.ISOP.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.MACR.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.MACR.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.MAP.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.MAP.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.MEK.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.MEK.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.MGLY.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.MGLY.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.MP.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.MP.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.MVK.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.MVK.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.N2O.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.N2O.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.N2O5.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.N2O5.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.NO.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.NO.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.NO2.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.NO2.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.NO3.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.NO3.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.NPMN.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.NPMN.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.O3.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.O3.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.OClO.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.OClO.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.OH.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.OH.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.PAN.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.PAN.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.PPN.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.PPN.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.PRPE.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.PRPE.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.R4N2.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.R4N2.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RCHO.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.RCHO.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIP.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.RIP.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIPA.geos5.2x25.nc) ]]; then ln -s /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIP.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIPA.geos.2x25.nc; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIPB.geos5.2x25.nc) ]]; then ln -s /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIP.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIPB.geos.2x25.nc; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIPB.geos5.2x25.nc) ]]; then ln -s /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIP.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIPD.geos.2x25.nc; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIPB.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.RIPB.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/gmi.clim.RIPD.geos5.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/GMI/v2015-02/gmi.clim.RIPD.geos5.2x25.nc /home/ubuntu/ExtData/HEMCO/GMI/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/IODINE/v2017-09/CH2I2_monthly_emissions_Ordonez_2012_COARDS.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/IODINE/v2017-09/CH2I2_monthly_emissions_Ordonez_2012_COARDS.nc /home/ubuntu/ExtData/HEMCO/IODINE/v2017-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/IODINE/v2017-09/CH2IBr_monthly_emissions_Ordonez_2012_COARDS.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/IODINE/v2017-09/CH2IBr_monthly_emissions_Ordonez_2012_COARDS.nc /home/ubuntu/ExtData/HEMCO/IODINE/v2017-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/IODINE/v2017-09/CH2ICl_monthly_emissions_Ordonez_2012_COARDS.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/IODINE/v2017-09/CH2ICl_monthly_emissions_Ordonez_2012_COARDS.nc /home/ubuntu/ExtData/HEMCO/IODINE/v2017-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/IODINE/v2017-09/CH3I_monthly_emissions_Ordonez_2012_COARDS.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/IODINE/v2017-09/CH3I_monthly_emissions_Ordonez_2012_COARDS.nc /home/ubuntu/ExtData/HEMCO/IODINE/v2017-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/AF_LANDMASK.geos.05x0666.global.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MASKS/v2018-09/AF_LANDMASK.geos.05x0666.global.nc /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/CONUS_Mask.01x01.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MASKS/v2018-09/CONUS_Mask.01x01.nc /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/Canada_mask.geos.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MASKS/v2018-09/Canada_mask.geos.1x1.nc /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/China_mask.generic.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MASKS/v2018-09/China_mask.generic.1x1.nc /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/MIX_Asia_mask.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MASKS/v2018-09/MIX_Asia_mask.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MASKS/v2018-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MASKS/v2019-05/India_mask.generic.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MASKS/v2019-05/India_mask.generic.1x1.nc /home/ubuntu/ExtData/HEMCO/MASKS/v2019-05/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_ACET.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_ACET.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_ALD2.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_ALD2.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_ALK4.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_ALK4.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_C3H8.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_C3H8.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_CH2O.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_CH2O.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_CO.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_CO.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_MEK.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_MEK.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_NH3.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_NH3.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_NO.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_NO.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_PRPE.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_PRPE.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/MIX_Asia_SO2.generic.025x025.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MIX/v2015-03/MIX_Asia_SO2.generic.025x025.nc /home/ubuntu/ExtData/HEMCO/MIX/v2015-03/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/MODIS_XLAI/v2017-07/2011/MODIS_XLAI.025x025.201107.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/MODIS_XLAI/v2017-07/2011/MODIS_XLAI.025x025.201107.nc /home/ubuntu/ExtData/HEMCO/MODIS_XLAI/v2017-07/2011/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc /home/ubuntu/ExtData/HEMCO/NEI2005/v2014-09/scaling/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean.nc /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_egu.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_egu.nc /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_egupk.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_egupk.nc /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_oilgas.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_oilgas.nc /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_othpt.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_othpt.nc /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_ptnonipm.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NEI2011/v2017-02-MM/07/NEI11_0.1x0.1_201107_monmean_ptnonipm.nc /home/ubuntu/ExtData/HEMCO/NEI2011/v2017-02-MM/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NH3/v2014-07/NH3_geos.4x5.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NH3/v2014-07/NH3_geos.4x5.nc /home/ubuntu/ExtData/HEMCO/NH3/v2014-07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NH3/v2018-04/NH3_Arctic_seabirds.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NH3/v2018-04/NH3_Arctic_seabirds.nc /home/ubuntu/ExtData/HEMCO/NH3/v2018-04/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/NOAA_GMD/v2018-01/monthly.gridded.surface.methane.1979-2020.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/NOAA_GMD/v2018-01/monthly.gridded.surface.methane.1979-2020.1x1.nc /home/ubuntu/ExtData/HEMCO/NOAA_GMD/v2018-01/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_BIOVOC/v2019-08/0.25x0.3125/2016/07/biovoc_025x03125.20160701.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_BIOVOC/v2019-08/0.25x0.3125/2016/07/biovoc_025x03125.20160701.nc /home/ubuntu/ExtData/HEMCO/OFFLINE_BIOVOC/v2019-08/0.25x0.3125/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_BIOVOC/v2019-08/0.25x0.3125/2016/07/biovoc_025x03125.20160702.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_BIOVOC/v2019-08/0.25x0.3125/2016/07/biovoc_025x03125.20160702.nc /home/ubuntu/ExtData/HEMCO/OFFLINE_BIOVOC/v2019-08/0.25x0.3125/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_DUST/v2019-01/0.25x0.3125/2016/07/dust_emissions_025.20160701.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_DUST/v2019-01/0.25x0.3125/2016/07/dust_emissions_025.20160701.nc /home/ubuntu/ExtData/HEMCO/OFFLINE_DUST/v2019-01/0.25x0.3125/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_DUST/v2019-01/0.25x0.3125/2016/07/dust_emissions_025.20160702.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_DUST/v2019-01/0.25x0.3125/2016/07/dust_emissions_025.20160702.nc /home/ubuntu/ExtData/HEMCO/OFFLINE_DUST/v2019-01/0.25x0.3125/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_LIGHTNING/v2019-01/GEOSFP/2016/FLASH_CTH_GEOSFP_0.25x0.3125_2016_07.nc4) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_LIGHTNING/v2019-01/GEOSFP/2016/FLASH_CTH_GEOSFP_0.25x0.3125_2016_07.nc4 /home/ubuntu/ExtData/HEMCO/OFFLINE_LIGHTNING/v2019-01/GEOSFP/2016/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_SEASALT/v2019-01/0.25x0.3125/2016/07/seasalt_025.20160701.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_SEASALT/v2019-01/0.25x0.3125/2016/07/seasalt_025.20160701.nc /home/ubuntu/ExtData/HEMCO/OFFLINE_SEASALT/v2019-01/0.25x0.3125/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_SEASALT/v2019-01/0.25x0.3125/2016/07/seasalt_025.20160702.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_SEASALT/v2019-01/0.25x0.3125/2016/07/seasalt_025.20160702.nc /home/ubuntu/ExtData/HEMCO/OFFLINE_SEASALT/v2019-01/0.25x0.3125/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_SOILNOX/v2019-01/0.25x0.3125/2016/07/soilnox_025.20160701.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_SOILNOX/v2019-01/0.25x0.3125/2016/07/soilnox_025.20160701.nc /home/ubuntu/ExtData/HEMCO/OFFLINE_SOILNOX/v2019-01/0.25x0.3125/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OFFLINE_SOILNOX/v2019-01/0.25x0.3125/2016/07/soilnox_025.20160702.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OFFLINE_SOILNOX/v2019-01/0.25x0.3125/2016/07/soilnox_025.20160702.nc /home/ubuntu/ExtData/HEMCO/OFFLINE_SOILNOX/v2019-01/0.25x0.3125/2016/07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OLSON_MAP/v2019-02/Olson_2001_Land_Type_Masks.025x025.generic.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OLSON_MAP/v2019-02/Olson_2001_Land_Type_Masks.025x025.generic.nc /home/ubuntu/ExtData/HEMCO/OLSON_MAP/v2019-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OMOC/v2018-01/OMOC.DJF.01x01.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OMOC/v2018-01/OMOC.DJF.01x01.nc /home/ubuntu/ExtData/HEMCO/OMOC/v2018-01/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OMOC/v2018-01/OMOC.JJA.01x01.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OMOC/v2018-01/OMOC.JJA.01x01.nc /home/ubuntu/ExtData/HEMCO/OMOC/v2018-01/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OMOC/v2018-01/OMOC.MAM.01x01.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OMOC/v2018-01/OMOC.MAM.01x01.nc /home/ubuntu/ExtData/HEMCO/OMOC/v2018-01/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/OMOC/v2018-01/OMOC.SON.01x01.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/OMOC/v2018-01/OMOC.SON.01x01.nc /home/ubuntu/ExtData/HEMCO/OMOC/v2018-01/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/STRAT/v2015-01/Bry/GEOSCCM_Bry.200707.day.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/STRAT/v2015-01/Bry/GEOSCCM_Bry.200707.day.nc /home/ubuntu/ExtData/HEMCO/STRAT/v2015-01/Bry/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/STRAT/v2015-01/Bry/GEOSCCM_Bry.200707.night.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/STRAT/v2015-01/Bry/GEOSCCM_Bry.200707.night.nc /home/ubuntu/ExtData/HEMCO/STRAT/v2015-01/Bry/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/TIMEZONES/v2015-02/timezones_voronoi_1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/TIMEZONES/v2015-02/timezones_voronoi_1x1.nc /home/ubuntu/ExtData/HEMCO/TIMEZONES/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/UVALBEDO/v2019-06/uvalbedo.geos.2x25.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/UVALBEDO/v2019-06/uvalbedo.geos.2x25.nc /home/ubuntu/ExtData/HEMCO/UVALBEDO/v2019-06/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/XIAO/v2014-09/C3H8_C2H6_ngas.geos.1x1.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/XIAO/v2014-09/C3H8_C2H6_ngas.geos.1x1.nc /home/ubuntu/ExtData/HEMCO/XIAO/v2014-09/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/LIGHTNOX/v2014-07/light_dist.ott2010.dat) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/LIGHTNOX/v2014-07/light_dist.ott2010.dat /home/ubuntu/ExtData/HEMCO/LIGHTNOX/v2014-07/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/ship_plume_lut_02ms.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/PARANOX/v2015-02/ship_plume_lut_02ms.nc /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/ship_plume_lut_06ms.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/PARANOX/v2015-02/ship_plume_lut_06ms.nc /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/ship_plume_lut_10ms.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/PARANOX/v2015-02/ship_plume_lut_10ms.nc /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/ship_plume_lut_14ms.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/PARANOX/v2015-02/ship_plume_lut_14ms.nc /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/; fi

if [[ !(-f /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/ship_plume_lut_18ms.nc) ]]; then aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/PARANOX/v2015-02/ship_plume_lut_18ms.nc /home/ubuntu/ExtData/HEMCO/PARANOX/v2015-02/; fi

