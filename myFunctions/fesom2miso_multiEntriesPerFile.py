# execute with e.g.: python fesom2miso.py iceOceanK 1000 1099 /work/ollie/orichter/MisomipPlus/output/IceOcean1r_COM_ocean_UaFesom_SSATsai.nc
# coding: utf-8

# In[1]:


import xarray as xr
import numpy as np
import sys
import os
import matplotlib.pyplot as plt
import sys
import pyfesom as pf
import pandas as pd
from scipy.interpolate import griddata
import pdb


# In[12]:


def get_monthly_ts(temp,salt,vol):
    weights = vol/vol.sum()
    ms = np.sum(salt*weights,1)
    mt = np.sum(temp*weights,1)
    
    return mt,ms

def get_monthly_melt(wnet,area,mask):
    area = area[mask]
    weights = area/area.sum()
    return np.sum(wnet[:,mask]*weights,1)

def get_int_series(exp,year):
    print('calculating integrated quantities')
    rhofw = 1000   
    year = str(year)

    meshpath = os.path.join(basedir,'fesommesh',exp,year)
    mesh = pf.fesom_mesh(meshpath, abg=[0,0,0],cavity=False,get3d=True)

    mdpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.mesh.diag.nc')
    md = xr.open_dataset(mdpath)

    dpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.forcing.diag.nc')
    frc = xr.open_dataset(dpath).sel(T=np.arange(1,13))

    dpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.oce.mean.nc')
    ocem = xr.open_dataset(dpath).sel(T=np.arange(1,13))   

    mr = get_monthly_melt(frc.wnet,md.cluster_area,mesh.cflag==1)

    A = md.cluster_area[mesh.cflag==1].sum()
    mf = mr*A*rhofw

    #n32cav = mesh.n32[mesh.cflag==1]
    #idxCav3d = n32cav[n32cav>0]
    #pdb.set_trace()
    #vol = md.cluster_vol[idxCav3d].sum()
    vol = md.cluster_vol.sum()
    vol = np.repeat(np.expand_dims(vol,1),12,0)

    mt,ms = get_monthly_ts(ocem.temp,ocem.salt,md.cluster_vol)        

    ds = xr.Dataset(
          {
              "meanMeltRate":(['nTime'],mr),
              "totalMeltFlux":(['nTime'],mf),
              'totalOceanVolume':(['nTime'],vol),
              'meanTemperature':(['nTime'],mt),
              'meanSalinity':(['nTime'],ms)
          },
          coords={
              'time':(['nTime'],ocem.time.values)
          })
    
    return ds


# In[3]:


def get_topo(meshpath,quant='shelf'):
    
    mesh = pf.fesom_mesh(meshpath, abg=[0,0,0],cavity=True)
    x_fesom = mesh.x2*111e3
    y_fesom = mesh.y2*111e3
    
    topoFile = os.path.join(meshpath,quant+'.out')
    file_content = pd.read_csv(topoFile, skiprows=0, names=['topo'] )
    topo_fesom  = file_content.topo.values
    
    miso_x, miso_y = np.meshgrid(misoGrd.x,misoGrd.y)
    miso_topo = griddata((x_fesom,y_fesom),topo_fesom,(miso_x,miso_y))
    
    return np.repeat(np.expand_dims(miso_topo,0),12,0)

def get_topo_series(exp,year):
    print('calculating draft and bathy')
    year = str(year)

    draft = get_topo(os.path.join(basedir,'fesommesh',exp,year))
    bathy = get_topo(os.path.join(basedir,'fesommesh',exp,year),'depth')

    dpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.forcing.diag.nc')
    frc = xr.open_dataset(dpath).sel(T=np.arange(1,13)) 
             
    ds = xr.Dataset(
          {
              "iceDraft":(['nTime','ny','nx'],draft),
              "bathymetry":(['nTime','ny','nx'],bathy)
          },
          coords={
              'time':(['nTime'],frc.time.values)
          })
    
    return ds


# In[4]:


def get_mask4d(dsTopo):
    print('calculating mask4d.')
    mask = xr.DataArray(
    np.empty((dsTopo.nTime.size,misoGrd.ny.size,misoGrd.nx.size,misoGrd.nz.size)),
    dims=('nTime',"ny",'nx','nz'))
    mask['nTime'] = dsTopo.nTime
    
    for itime in mask.nTime:
        for iz in range(misoGrd.z.size):
            depth = misoGrd.z[iz].values
            bathy = dsTopo.bathymetry[itime]
            draft = dsTopo.iceDraft[itime]
            mask[itime,:,:,iz] = (depth>bathy) & (depth<draft)
    mask = mask.astype(bool)
    mask.attrs['flag']='True = ocean / False = ice or bedrock'
    
    return mask


# In[5]:


def get_slayer_avg(d,mesh):
    avg = np.empty((12,mesh.n2d))
    idx0 = mesh.n32[:,0]
    idx1 = mesh.n32[:,1]
    for i in range(12):    
        avg[i] = (d[i,idx0]+d[i,idx1])*0.5
    return avg

def intp_fesom2miso(fd,mesh,cavity_only=True):
    
    if cavity_only:
        fx = mesh.x2[mesh.cflag==1]
        fy = mesh.y2[mesh.cflag==1]
        fd = fd[:,mesh.cflag==1]
    else:
        fx = mesh.x2
        fy = mesh.y2

    x_fesom = fx*111e3
    y_fesom = fy*111e3
    miso_x, miso_y = np.meshgrid(misoGrd.x,misoGrd.y)
    md = np.empty((12,miso_x.shape[0],miso_x.shape[1]))
    for i in range(12):
        md[i] = griddata((x_fesom,y_fesom),fd[i],(miso_x,miso_y))
        
    return md

def get_melt_series(exp,year):
    print('extracting melt rates and calculating its drivers')
    year = str(year)

    meshpath = os.path.join(basedir,'fesommesh',exp,year)
    mesh = pf.fesom_mesh(meshpath, abg=[0,0,0],cavity=False,get3d=True)

    dpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.forcing.diag.nc')
    frc = xr.open_dataset(dpath).sel(T=np.arange(1,13))

    dpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.oce.mean.nc')
    ocem = xr.open_dataset(dpath).sel(T=np.arange(1,13))

    melt = intp_fesom2miso(frc.wnet,mesh)  

    u = get_slayer_avg(ocem.u,mesh)
    v = get_slayer_avg(ocem.v,mesh)

    ustar = np.sqrt(2.5e-3 * (u**2 + v**2 + 0.01**2))
    ustar = intp_fesom2miso(ustar,mesh)

    u = intp_fesom2miso(u,mesh)
    v = intp_fesom2miso(v,mesh)

    temp = get_slayer_avg(ocem.temp,mesh)
    tempD = temp - frc.Tsurf
    tempD = intp_fesom2miso(tempD,mesh)

    salt = get_slayer_avg(ocem.salt,mesh)
    saltD = salt - frc.Ssurf
    saltD = intp_fesom2miso(saltD,mesh)
         
    ds = xr.Dataset(
          {
              "meltRate":(['nTime','ny','nx'],melt),
              "frictionVelocity":(['nTime','ny','nx'],ustar),
              "thermalDriving":(['nTime','ny','nx'],tempD),
              "halineDriving":(['nTime','ny','nx'],saltD),
              "uBoundaryLayer":(['nTime','ny','nx'],u),
              "vBoundaryLayer":(['nTime','ny','nx'],v)
          },
          coords={
              'time':(['nTime'],ocem.time.values)
          })
    
    return ds


# In[6]:


def get_bottomTS_series(exp,year):
    print('getting bottom salt and temp')
    year = str(year)

    meshpath = os.path.join(basedir,'fesommesh',exp,year)
    mesh = pf.fesom_mesh(meshpath, abg=[0,0,0],cavity=False,get3d=True)

    dpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.oce.mean.nc')
    ocem = xr.open_dataset(dpath).sel(T=np.arange(1,13))

    ibot = []
    for icol in range(mesh.n2d):
        col = mesh.n32[icol]
        col = col[col>0]-1
        ibot.append(col[-1])

    mlon = misoGrd.x/111e3
    mlat = misoGrd.y/111e3
    mlons,mlats = np.meshgrid(mlon,mlat)

    btemp = np.empty((12,misoGrd.ny.size,misoGrd.nx.size))
    bsalt = btemp.copy()

    for i in range(12):
        btemp[i] = pf.fesom2regular(ocem.temp[i,ibot].values, mesh, mlons, mlats, how='nn', radius_of_influence=1500)
        bsalt[i] = pf.fesom2regular(ocem.salt[i,ibot].values, mesh, mlons, mlats, how='nn', radius_of_influence=1500)

    ds = xr.Dataset(
          {
              "bottomTemperature":(['nTime','ny','nx'],btemp),
              "bottomSalinity":(['nTime','ny','nx'],bsalt)
          },
          coords={
              'time':(['nTime'],ocem.time.values)
          })
    
    return ds


# In[7]:


def get_transTS_series(exp,year):
    print('extracting TS transects')
    year = str(year)

    meshpath = os.path.join(basedir,'fesommesh',exp,year)
    mesh = pf.fesom_mesh(meshpath, abg=[0,0,0],cavity=False,get3d=True)

    dpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.oce.mean.nc')
    ocem = xr.open_dataset(dpath).sel(T=np.arange(1,13))

    x3 = np.empty_like(mesh.zcoord)
    y3 = np.empty_like(mesh.zcoord)
    for col in mesh.n32:
        col=col[col>0]-1
        x = mesh.x2[col[0]]
        y = mesh.y2[col[0]]
        x3[col]=x*111e3
        y3[col]=y*111e3
    z3 = -mesh.zcoord

    tempxz = np.ma.empty((12,misoGrd.z.size,misoGrd.x.size))
    saltxz = tempxz.copy()

    tempyz = np.ma.empty((12,misoGrd.z.size,misoGrd.y.size))
    saltyz = tempyz.copy()

    for i in range(12):

        Z,Y,X = np.meshgrid(misoGrd.z,40e3,misoGrd.x)
        maskxz = (mask4d.isel(nTime=i,ny=19) & mask4d.isel(nTime=i,ny=20))
        maskyz = (mask4d.isel(nTime=i,nx=99) & mask4d.isel(nTime=i,nx=100))

        temp = griddata((z3,y3,x3),ocem.temp[i].values,(Z,Y,X),method='nearest').squeeze()
        tempxz[i]=xr.DataArray(temp,dims=('nz','nx')).where(maskxz)

        salt = griddata((z3,y3,x3),ocem.salt[i].values,(Z,Y,X),method='nearest').squeeze()
        saltxz[i]=xr.DataArray(salt,dims=('nz','nx')).where(maskxz)

        Y,Z,X = np.meshgrid(misoGrd.y,misoGrd.z,520e3)

        temp = griddata((z3,y3,x3),ocem.temp[i].values,(Z,Y,X),method='nearest').squeeze()
        tempyz[i]=xr.DataArray(temp,dims=('nz','ny')).where(maskyz)

        salt = griddata((z3,y3,x3),ocem.salt[i].values,(Z,Y,X),method='nearest').squeeze()
        saltyz[i]=xr.DataArray(salt,dims=('nz','ny')).where(maskyz)
             
    ds = xr.Dataset(
          {
              "temperatureXZ":(['nTime','nz','nx'],tempxz),
              "salinityXZ":(['nTime','nz','nx'],saltxz),
              "temperatureYZ":(['nTime','nz','ny'],tempyz),
              "salinityYZ":(['nTime','nz','ny'],saltyz)
          },
          coords={
              'time':(['nTime'],ocem.time.values)
          })
    
    return ds


# In[8]:


def get_stream(v,w,mesh):#v comes as 12 months

    x3 = np.empty_like(mesh.zcoord)
    y3 = np.empty_like(mesh.zcoord)
    for col in mesh.n32:
        col=col[col>0]-1
        x = mesh.x2[col[0]]
        y = mesh.y2[col[0]]
        x3[col]=x*111e3
        y3[col]=y*111e3
    z3 = -mesh.zcoord
    
    X,Y,Z = np.meshgrid(misoGrd.x,misoGrd.y,misoGrd.z)
    
    bs=np.empty((12,misoGrd.y.size,misoGrd.x.size))
    ms= np.empty((12,misoGrd.x.size,misoGrd.z.size))
    
    print('processing months... ')
    for imonth in range(12):
        vm = griddata((x3,y3,z3),v[imonth].values,(X,Y,Z),method='nearest')
        vm = xr.DataArray(vm,dims=('ny','nx','nz')).where(mask4d[imonth])
        bs[imonth] = ((vm*5).sum('nz')*2000).cumsum('nx').where(mask4d[imonth].any('nz'))
        
        wm = griddata((x3,y3,z3),w[imonth].values,(X,Y,Z),method='nearest')
        wm = xr.DataArray(wm,dims=('ny','nx','nz')).where(mask4d[imonth])
        ms[imonth] = ((wm*2000).sum('ny')*2000).cumsum('nx').where(mask4d[imonth].any('ny'))
        
    return bs,ms


def get_stream_series(exp,year):
    print('calculating stream functions ...')
    year = str(year)

    meshpath = os.path.join(basedir,'fesommesh',exp,year)
    mesh = pf.fesom_mesh(meshpath, abg=[0,0,0],cavity=False)

    dpath = os.path.join(basedir,'fesomdata',exp,exp+'.'+year+'.oce.mean.nc')
    ocem = xr.open_dataset(dpath).sel(T=np.arange(1,13))

    draft = get_topo(meshpath)
    bathy = get_topo(meshpath,'depth')

    bs,ms = get_stream(ocem.v,ocem.w,mesh)
             
    ds = xr.Dataset(
          {
              "barotropicStreamfunction":(['nTime','ny','nx'],bs),
              "overturningStreamfunction":(['nTime','nx','nz'],ms)
          },
          coords={
              'time':(['nTime'],ocem.time.values)
          })
    
    return ds


# In[9]:


def fesom2miso(exp,years,outpath=False):
    global misoGrd, mask4d, basedir
    
    basedir = '/work/ollie/orichter/MisomipPlus/'
    
    misoGrd = xr.Dataset(
         coords={
                'x':('nx',np.arange(3.21e5,8.00e5,0.02e5)),
                'y':('ny',np.arange(1.0e3,8.0e4,2.0e3)),
                'z':('nz',np.arange(-2.5,-718.0,-5))
                   })
      
    cnt=0
    for year in years:
        print('processing year '+str(year-1000))
        
        dsInt = get_int_series(exp,year)
        dsTopo = get_topo_series(exp,year)
        mask4d = get_mask4d(dsTopo)
        dsMelt = get_melt_series(exp,year)
        dsBottom = get_bottomTS_series(exp,year)
        dsTrans = get_transTS_series(exp,year)
        dsStream = get_stream_series(exp,year)

        print('merging data into single dataset for the year')
        ds_tmp = xr.merge([dsInt, dsTopo, dsMelt, dsBottom, dsTrans, dsStream])
        
        
        days = np.cumsum(np.array([0,31,28,31,30,31,30,31,31,30,31,30]))
        fdom = days+365*(year-1000)
        print('assigning time (days):',fdom)
        ds_tmp.time.values = fdom*24*3600
        
        print('assigning attributes, incl. _FillValue')
        for k,v in ds_tmp.items():
            if v.isnull().any():
                ds_tmp[k].attrs['_FillValue']=np.nan

        print('concatenating to the overloard dataset.')
        if cnt==0:
            ds = ds_tmp
            cnt+=1
        else:
            ds = xr.concat([ds,ds_tmp],dim='nTime')
            
        if outpath:
            print('saving to '+outpath)
            ds.astype('float32').to_netcdf(outpath)
            #[expt]_COM_[component]_[MODEL_CONFIG].nc

    return


# In[10]:


# Command-line interface
if __name__ == "__main__":

    n = len(sys.argv)
 
    print("\nArguments passed:\n")
    for i in range(1, n):
        print(sys.argv[i])
    
    exp = sys.argv[1]
    y1 = int(sys.argv[2])
    y2 = int(sys.argv[3])
    outDir = sys.argv[4]

    fesom2miso(exp,np.arange(y1,y2+1),outDir)


# In[ ]:


fesom2miso('iceOceanK',np.arange(1000,1065),'/work/ollie/orichter/MisomipPlus/IceOcean1r_COM_ocean_uaFesom.nc')


# In[16]:


get_ipython().magic(u'debug')

